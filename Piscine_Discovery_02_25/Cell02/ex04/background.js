document.getElementById('colorButton').onclick = function() {
    var couleurs = '0123456789ABCDEF';
    var couleurAleatoire = '#';
    for (var i = 0; i < 6; i++) {
        couleurAleatoire += couleurs[Math.floor(Math.random() * 16)];
    }
    document.body.style.backgroundColor = couleurAleatoire;
};