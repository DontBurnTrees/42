#include <unistd.h>

int	main(int argc, char **argv)
{
	int	i = 1;

	while (i < argc)
	{
		int	y = 0;
		while (argv[i][y])
		{
			write (1, &argv[i][y], 1);
			y++;
		}
		write (1, "\n", 1);
		i++;
	}
}
