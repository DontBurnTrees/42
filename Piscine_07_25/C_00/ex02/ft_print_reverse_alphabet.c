#include <unistd.h>

void	ft_print_reverse_alphabet(void)
{
	int	rev = 'z';

	while (rev >= 'a')
	{
		write(1, &rev, 1);
		rev--;
	}
}

/*int	main(void)
{
	ft_print_reverse_alphabet();
	return(0);
}*/
