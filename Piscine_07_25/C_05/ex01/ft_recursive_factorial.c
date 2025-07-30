/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_recursive_factorial.c                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nlopinet <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/07/30 15:49:39 by nlopinet          #+#    #+#             */
/*   Updated: 2025/07/30 18:21:51 by nlopinet         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>

int	ft_recursive_factorial(int nb)
{
	if (nb > 1)
	{
		return (nb * ft_recursive_factorial(nb - 1));
	}
	if (nb == 0 || nb == 1)
		return (1);
	return (0);
}

/*int	main(void)
{
	printf("%d\n", ft_recursive_factorial(6));
	printf("%d\n", ft_recursive_factorial(4));
	return (0);
}*/
