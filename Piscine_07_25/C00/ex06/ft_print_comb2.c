#include <unistd.h>

void    print_number(int n)
{
        char	d;
        char	u;

	d = (n / 10) + '0';
	u = (n % 10) + '0';
        write(1, &d, 1);
        write(1, &u, 1);
}

void	ft_print_comb2(void)
{
	int	n1;
	int	n2;

	n1 = 0;
	while (n1 <= 98)
	{
		n2 = n1 + 1;
		while (n2 <= 99)
		{
			print_number(n1);
			write(1, " ", 1);
			print_number(n2);
			if (!(n1 == 98 && n2 == 99))
				write(1, ", ", 2);
			n2++;
		}
		n1++;
	}
}

/*int	main(void){
	ft_print_comb2();
}*/
