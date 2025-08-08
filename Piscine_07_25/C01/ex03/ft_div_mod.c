#include <stdio.h>

void	ft_div_mod(int a, int b, int *div, int *mod)
{
	*div = a / b;
	*mod = a % b;
}

/*int	main(void)
{
	int	a = 2;
	int	b = 20;
	int	mod = 0;
	int	div = 0;
	
	ft_div_mod(a,b,&div,&mod);
	printf("div = %d mod = %d",div,mod);
	return (0);
}*/
