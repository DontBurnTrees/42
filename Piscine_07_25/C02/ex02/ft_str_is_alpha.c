#include <stdio.h>

int	ft_str_is_alpha(char *str)
{
	int	a;

	a = 0;
	while (str[a] != '\0')
	{
		if (!((str[a] >= 'a' && str[a] <= 'z') ||
		(str[a] >= 'A' && str[a] <= 'Z'))) 
		{
			return (0);
		}
		a++;
	}
	return (1);
}

/*int	main(void)
{
	printf("%d\n", ft_str_is_alpha("phrase"));
	printf("%d\n", ft_str_is_alpha("PHRASE"));
	printf("%d\n", ft_str_is_alpha("phr4se"));
	return (0);
}*/
