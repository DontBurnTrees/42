#include <stdio.h>

int	ft_recursive_power(int nb, int power)
{
	if (power < 0)
		return (0);
	if (power == 1)
		return (nb);
	if (power == 0)
		return (0);
	if (power == 0 && nb == 0)
		return (1);
	else if (nb == 0)
		return (0);
	return (nb * ft_recursive_power(nb, power - 1));
}

/*int	main(void)
{
	printf("%d\n", ft_recursive_power(3, 3));
	printf("%d\n", ft_recursive_power(3, 2));
	printf("%d\n", ft_recursive_power(3, 1));
	printf("%d\n", ft_recursive_power(1, 3));
	printf("%d\n", ft_recursive_power(2, 3));
	printf("%d\n", ft_recursive_power(3, 3));
}*/
