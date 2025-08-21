#include <stdio.h>

void	ft_rev_int_tab(int *tab, int size)
{
	int	i = 0;
	int	j = size - 1;
	int 	tmp;

	while (i < j)
	{
		tmp = tab[i];
		tab[i] = tab[j];
		tab[j] = tmp;
		i++;
		j--;
	}
}

/*int	main(void)
{
	int	tab[] = {1, 2, 3, 4, 5};
	int	size = 5;
	int	i;

	ft_rev_int_tab(tab, size);

	while (i < size)
	{
		printf("%d ", tab[i]);
		i++;
	}
	printf("\n");
}*/
