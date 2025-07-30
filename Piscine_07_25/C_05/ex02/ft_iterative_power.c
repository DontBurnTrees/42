/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_iterative_power.c                               :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nlopinet <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/07/30 15:47:28 by nlopinet          #+#    #+#             */
/*   Updated: 2025/07/30 18:22:22 by nlopinet         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>

int	ft_iterative_power(int nb, int power)
{
	int	i;
	int	temp;

	temp = 1;
	i = 1;
	if (power == 0)
		return (1);
	if (power < 0)
		return (0);
	while (i <= power)
	{
		temp *= nb;
		i++;
	}
	return (temp);
}

/*int	main(void)
{
	printf("%d\n", ft_iterative_power(3, 3));
	printf("%d\n", ft_iterative_power(2, 2));
}*/
