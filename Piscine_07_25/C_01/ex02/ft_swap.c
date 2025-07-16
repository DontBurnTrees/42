/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_swap.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nlopinet <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/07/10 14:41:08 by nlopinet          #+#    #+#             */
/*   Updated: 2025/07/16 15:22:09 by nlopinet         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

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
