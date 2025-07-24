#include <stdio.h>

int	ft_str_is_numeric(char *str)
{
	int	a;

	a = 0;
	while (str[a] != '\0')
	{
		if (!(str[a] >= '0' && str[a] <= '9'))
		{
			return (0);
		}
		a++;
	}
	return (1);
}

/*int	main(void)
{
	printf("%d\n", ft_str_is_numeric("123456789"));
	printf("%d\n", ft_str_is_numeric("123a56789"));
	return (0);
}*/
