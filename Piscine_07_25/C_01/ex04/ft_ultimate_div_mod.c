#include <stdio.h>

void	ft_ultimate_div_mod(int *a, int *b)
{
	int	temp1;
	int	temp2;

	temp1 = *a / *b;
	temp2 = *a % *b;
	*a = temp1;
	*b = temp2;
}

/*int	main(void)
{
	int a;
	int b;

	a = 20;
	b = 3;
	ft_ultimate_div_mod(&a, &b);
	printf("a = %d b = %d", a, b);
	return (0);
}*/
