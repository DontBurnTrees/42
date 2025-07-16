#include <stdio.h>

void	ft_swap(int *a, int *b)
{
	int	swap;

	swap = *a;
	*a = *b;
	*b = swap;
}

/*int	main(void)
{
	int	a;
	int	b;
	
	a = 10;
	b = 20;
	printf("avant le swap, a = %i, b = %i\n", a, b); 
	ft_swap(&a, &b);
	printf("apres le swap, a = %i, b = %i\n", a, b); 
	return (0);
}*/
