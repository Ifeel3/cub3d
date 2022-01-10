NAME = cub3D

SRCS =	srcs/control/close_game.c				srcs/control/turn_right.c\
		srcs/control/key_hook.c					srcs/control/strafe_left.c\
		srcs/control/strafe_right.c				srcs/control/turn_left.c\
		srcs/control/walk_forward.c				srcs/control/walk_backward.c\
		srcs/control/move.c						srcs/graphic/pixel_put.c\
		srcs/graphic/render.c					srcs/parser/get_map_ids.c\
		srcs/gnl/get_next_line_utils.c			srcs/gnl/get_next_line.c\
		srcs/utils/free_str_arr.c				srcs/utils/rbg_to_hex.c\
		srcs/parser/parse_identifiers.c			srcs/utils/is_map_started.c\
		srcs/parser/get_map.c					srcs/parser/build_map.c\
		srcs/parser/parse_utils/is_extra.c		srcs/parser/parse_utils/is_only_spaces.c\
		srcs/parser/parse_utils/gll.c			srcs/parser/check_map.c\
		srcs/parser/parse_utils/is_map_closed.c	srcs/graphic/dtr.c\
		srcs/parser/parse_utils/save_line.c		srcs/parser/parse_utils/fucked_up_clear.c\
		srcs/graphic/draw_floor_and_cell.c		srcs/graphic/calc_raypos.c\
		srcs/graphic/put_texture.c				srcs/graphic/rays.c\
		srcs/graphic/select_text.c				srcs/graphic/select_color.c

MAIN = srcs/main.c

LIBFT = srcs/libft/libft.a
MLX = minilibx_macOS/libmlx.a

OBJS = $(patsubst %.c,$(OBJS_DIR)/%.o, $(SRCS))
D_FILES = $(patsubst %.c,$(OBJS_DIR)/%.d, $(SRCS))
OBJS_DIR = objs
ALL_OBJS_DIRS = $(sort $(dir $(OBJS)))

CC = gcc
FLAGS = -Wall -Wextra -Werror
MAC_API = -framework OpenGL -framework AppKit
MLX_API = -Lminilibx_macOS -lmlx
DEBUG = -g

#colors for beauty
YELLOW =	\033[33;1m
RESET =		\033[0m
RED =		\033[31;1m
GREEN =		\033[32;1m
MAGENTA =	\033[35;1m

ERASE = \33[2K

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(MLX) $(LIBFT) $(ALL_OBJS_DIRS) $(OBJS) $(MAIN)
	@$(CC) $(FLAGS) -D DEBUG -Iincludes -Iminilibx_macOS $(MLX_API) $(MAC_API) $(MAIN) $(OBJS) $(LIBFT) -o $(NAME)
	@echo "\n$(MAGENTA)$(NAME) $(GREEN)compiled$(RESET)"

$(LIBFT):
	@make -C $(dir $(LIBFT))

$(MLX):
	@make -C $(dir $(MLX))
	@echo "$(MAGENTA)mlx $(GREEN)ready$(RESET)"

$(ALL_OBJS_DIRS): $(OBJS_DIR)
	@mkdir -p $@

$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

$(OBJS_DIR)/%.o:%.c
	@$(CC) $(FLAGS) -Iincludes -Iminilibx_macOS -c $< -o $@ -MMD
	@printf "$(ERASE)$(RED)>> $(YELLOW)[$@]$(GREEN)$(RESET)\r"

include $(wildcard $(D_FILES))

clean:
	@rm -rf $(OBJS_DIR)
	@make clean -C $(dir $(MLX))
	@make fclean -C $(dir $(LIBFT))
	@echo "$(MAGENTA)libmlx.a $(RED)deleted$(RESET)"
	@echo "$(YELLOW)objs $(RED)deleted$(RESET)"

fclean: clean
	@rm -rf $(NAME)
	@echo "$(MAGENTA)$(NAME) $(RED)deleted$(RESET)"

re: fclean all
