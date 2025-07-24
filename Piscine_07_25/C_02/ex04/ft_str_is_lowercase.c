#include <stdio.h>

int	ft_str_is_lowercase(char *str)
{
	int	a;

	a = 0;
	while (str[a] != '\0')
	{
		if (!(str[a] >= 'a' && str[a] <= 'z'))
		{
			return (0);
		}
		a++;
	}
	return (1);
}

/*int	main(void)
{
	printf("%d\n", ft_str_is_lowercase("nemangepasdepain"));
	printf("%d\n", ft_str_is_lowercase("Nemangepasdepain"));
	printf("%d\n", ft_str_is_lowercase("nemang3pasdepain"));
	return (0);
}*/
