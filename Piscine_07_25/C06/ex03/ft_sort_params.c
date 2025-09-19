#include <unistd.h>
int	ft_strcmp(char *s1, char *s2)
{
	int	i = 0;
	while (s1[i] && s1[i] == s2[i])
		i++;
	return (s1[i] - s2[i]);
}

int	main(int argc, char **argv)
{
	int	i = 1;
	int	x = 1;
	
	while (x < argc - 1)
	{
		if (ft_strcmp(argv[x], argv[x + 1]) > 0)
		{
			char *temp = argv[x];
			argv[x] = argv[x + 1];
			argv[x + 1] = temp;
		}
		x++;
	}




	while (i < argc)
	{
		int	 y = 0;

		while (argv[i][y])
		{
			write(1, &argv[i][y], 1);
			y++;
		}
		write(1, "\n", 1);
		i++;
	}
}
