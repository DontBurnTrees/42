#include <stdio.h>

int	ft_str_is_uppercase(char *str)
{
	int	a;

	a = 0;
	while (str[a] != '\0')
	{
		if (!(str[a] >= 'A' && str[a] <= 'Z'))
		{
			return (0);
		}
		a++;
	}
	return (1);
}

/*int	main(void)
{
	printf("%d\n", ft_str_is_uppercase("SUN"));
	printf("%d\n", ft_str_is_uppercase("SuN"));
	printf("%d\n", ft_str_is_uppercase("S0N"));
	return (0);
}*/
