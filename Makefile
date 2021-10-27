NAME = cub3d

SRCS =	srcs/control/close_game.c		srcs/control/turn_right.c\
		srcs/control/key_hook.c			srcs/control/strafe_left.c\
		srcs/control/strafe_right.c		srcs/control/turn_left.c\
		srcs/control/walk_forward.c		srcs/control/walk_backward.c\
		srcs/control/move.c				srcs/graphic/pixel_put.c\
		srcs/graphic/render.c			srcs/parser/parser.c\
		srcs/gnl/get_next_line_utils.c	srcs/gnl/get_next_line.c\
		srcs/utils/ft_strcmp.c			srcs/utils/ft_split.c\
		srcs/utils/ft_substr.c			srcs/utils/free_str_arr.c\
		srcs/utils/ft_strlen.c

MAIN = srcs/main.c

LIBFT = srcs/libft/libft.a

OBJS = $(patsubst %.c,$(OBJS_DIR)/%.o, $(SRCS))
D_FILES = $(patsubst %.c,$(OBJS_DIR)/%.d, $(SRCS))
OBJS_DIR = objs

MLX = minilibx_macOS/libmlx.a

CC = gcc
#FLAGS = -Wall -Wextra -Werror
MAC_API = -framework OpenGL -framework AppKit

#colors for beauty
YELLOW =	\033[33;1m
RESET =		\033[0m
RED =		\033[31;1m
GREEN =		\033[32;1m
MAGENTA =	\033[35;1m

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(MLX) $(LIBFT) $(OBJS_DIR) $(OBJS) $(MAIN)
	@$(CC) $(FLAGS) -Iincludes -Lminilibx_macOS -lmlx $(MAC_API) $(MAIN) $(OBJS) -o $(NAME)
	@echo "$(MAGENTA)$(NAME) $(GREEN)compiled$(RESET)"

$(LIBFT):
	@make -C srcs/libft
	@echo "$(MAGENTA)libft.a $(GREEN)ready$(RESET)"

$(MLX):
	@make -C minilibx_macOS
	@echo "$(MAGENTA)mlx $(GREEN)ready$(RESET)"

$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)
	@mkdir -p $(OBJS_DIR)/srcs
	@mkdir -p $(OBJS_DIR)/srcs/control
	@mkdir -p $(OBJS_DIR)/srcs/graphic
	@mkdir -p $(OBJS_DIR)/srcs/gnl
	@mkdir -p $(OBJS_DIR)/srcs/utils
	@mkdir -p $(OBJS_DIR)/srcs/parser

$(OBJS_DIR)/%.o:%.c
	@$(CC) $(FLAGS) -Iincludes -Iminilibx_macOS -c $< -o $@ -MD
	@echo "$(YELLOW)objs $(GREEN)ready$(RESET)"

include $(wildcard $(D_FILES))

clean:
	@rm -rf $(OBJS_DIR)
	@make clean -C minilibx_macOS
	@make fclean -C srcs/libft
	@echo "$(MAGENTA)libmlx.a $(RED)deleted$(RESET)"
	@echo "$(MAGENTA)libft.a $(RED)deleted$(RESET)"
	@echo "$(YELLOW)objs $(RED)deleted$(RESET)"

fclean: clean
	@rm -rf $(NAME)
	@echo "$(MAGENTA)$(NAME) $(RED)deleted$(RESET)"

re: fclean all
