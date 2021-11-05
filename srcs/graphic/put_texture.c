/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   put_texture.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lvallie <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/11/05 20:06:44 by lvallie           #+#    #+#             */
/*   Updated: 2021/11/05 20:06:46 by lvallie          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "cub3d.h"

void	put_texture(t_data *data)
{
	double	tex_pos;

	data->ray.distance *= cos(data->player.angle - data->ray.angle);
	data->ray.height = (int)(data->focus * SIZE / data->ray.distance);
	data->ray.scale = 64 / (double)data->ray.height;
	data->ray.start = (W_HEIGHT - data->ray.height) / 2;
	data->ray.end = data->ray.start + data->ray.height;
	tex_pos = 0;
	select_text(data);
	while (data->ray.start < data->ray.end)
	{
		if (data->ray.start >= 0 && data->ray.start < W_HEIGHT
			&& data->ray.number >= 0 && data->ray.number < W_WIDTH)
			pixel_put(data, data->ray.number, data->ray.start,
				  *(int *)(data->ray.texture.addr
					  + (int)tex_pos * (data->ray.texture.bpp / 8)));
		tex_pos += data->ray.scale;
		data->ray.start++;
	}
}
