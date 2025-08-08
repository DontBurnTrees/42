int ft_strlen(char *str)
{
    int i = 0;
    while (str[i] != '\0')
        i++;
    return i;
}

/*
#include <stdio.h>

int main(void)
{
    char *test = "Hello, world!";
    printf("Length: %d\n", ft_strlen(test));
    return 0;
}
*/


#include <unistd.h>

void ft_putstr(char *str)
{
    int i = 0;
    while (str[i] != '\0')
    {
        write(1, &str[i], 1);
        i++;
    }
}

/*
int main(void)
{
    char *test = "Hello, ft_putstr!\n";
    ft_putstr(test);
    return 0;
}
*/


#include <unistd.h>

void ft_putnbr(int nb)
{
    char c;

    if (nb == -2147483648) // cas spécial INT_MIN
    {
        write(1, "-2147483648", 11);
        return;
    }
    if (nb < 0)
    {
        write(1, "-", 1);
        nb = -nb;
    }
    if (nb >= 10)
        ft_putnbr(nb / 10);
    c = (nb % 10) + '0';
    write(1, &c, 1);
}

/*
int main(void)
{
    ft_putnbr(42);
    write(1, "\n", 1);
    ft_putnbr(-2147483648);
    write(1, "\n", 1);
    ft_putnbr(0);
    write(1, "\n", 1);
    ft_putnbr(-12345);
    write(1, "\n", 1);
    return 0;
}
*/
int ft_atoi(char *str)
{
    int i = 0;
    int sign = 1;
    int result = 0;

    // Ignore espaces blancs (tab, espace, newline, etc.)
    while (str[i] == ' ' || (str[i] >= 9 && str[i] <= 13))
        i++;

    // Gère les '+' et '-'
    while (str[i] == '+' || str[i] == '-')
    {
        if (str[i] == '-')
            sign = -sign;
        i++;
    }

    // Convertit les chiffres
    while (str[i] >= '0' && str[i] <= '9')
    {
        result = result * 10 + (str[i] - '0');
        i++;
    }

    return sign * result;
}

/*
#include <stdio.h>

int main(int argc, char **argv)
{
    if (argc == 2)
        printf("%d\n", ft_atoi(argv[1]));
    return 0;
}
*/
