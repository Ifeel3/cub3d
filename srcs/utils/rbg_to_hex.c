/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   rbg_to_hex.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: ikael <ikael@student.42.fr>                +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/10/28 12:01:14 by ikael             #+#    #+#             */
/*   Updated: 2021/10/28 12:01:31 by ikael            ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "cub3d.h"

int	rgb_to_hex(int red, int green, int blue)
{
	return ((((red * 256) + green) * 256) + blue);
}