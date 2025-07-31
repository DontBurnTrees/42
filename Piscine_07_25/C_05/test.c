#include <stdio.h>

int ft_fibonacci(int index)
{
    if (index < 0)
        return -1;
    if (index == 0)
        return 0;
    if (index == 1)
        return 1;
    return ft_fibonacci(index - 1) + ft_fibonacci(index - 2);
}

/*
int main(void)
{
    printf("%d\n", ft_fibonacci(7));
    return 0;
}
*/

#include <stdio.h>

int ft_sqrt(int nb)
{
    int i;

    if (nb <= 0)
        return 0;

    i = 1;
    while (i * i <= nb && i <= 46340)
    {
        if (i * i == nb)
            return i;
        i++;
    }
    return 0;
}

/*
int main(void)
{
    printf("%d\n", ft_sqrt(25));
    return 0;
}
*/

#include <stdio.h>

int ft_recursive_power(int nb, int power)
{
    if (power < 0)
        return 0;
    if (power == 0)
        return 1;
    return nb * ft_recursive_power(nb, power - 1);
}

/*
int main(void)
{
    printf("%d\n", ft_recursive_power(2, 3));  // Affiche 8
    return 0;
}
*/


#include <stdio.h>

int ft_atoi(char *str)
{
    int i = 0;
    int sign = 1;
    int result = 0;

    while (str[i] == ' ' || str[i] == '\t' || str[i] == '\n'
        || str[i] == '\v' || str[i] == '\f' || str[i] == '\r')
        i++;

    while (str[i] == '+' || str[i] == '-')
    {
        if (str[i] == '-')
            sign *= -1;
        i++;
    }

    while (str[i] >= '0' && str[i] <= '9')
    {
        result = result * 10 + (str[i] - '0');
        i++;
    }

    return result * sign;
}

/*
int main(void)
{
    printf("%d\n", ft_atoi(" ---+--+1234ab567"));
    return 0;
}
*/
