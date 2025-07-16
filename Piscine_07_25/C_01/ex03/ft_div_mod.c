/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_div_mod.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nlopinet <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/07/15 08:54:24 by nlopinet          #+#    #+#             */
/*   Updated: 2025/07/16 15:18:14 by nlopinet         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

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
