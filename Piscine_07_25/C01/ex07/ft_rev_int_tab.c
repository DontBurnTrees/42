#include <stdio.h>

void	ft_swap(int *a, int *b){
	int	temp;

	temp = *a;
	*a = *b;
	*b = temp;
}

void	ft_rev_int_tab(int *tab, int size)
{
	int	i = 0;
	int	j = size - 1;

	while (i < j)
	{
		ft_swap(&tab[i], &tab[j]);
		i++;
		j--;
	}
}

void    print_tab(int *tab, int size)
{
    int i = 0;

    while (i < size)
    {
        printf("%d ", tab[i]);
        i++;
    }
    printf("\n");
}

/*int	main(void)
{
	int	tab[5] = {1, 2, 3, 4, 5};

	ft_rev_int_tab(tab, 5);
	print_tab(tab, 5);
}*/
