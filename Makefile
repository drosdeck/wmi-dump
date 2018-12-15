NAME	= wmidump

CC	= gcc

SRCS	= wmidump.c

OBJS	=	$(SRCS:.c=.o)

CFLAGS	?= -O2 -ggdb3
CFLAGS	+= -Wall -W -std=gnu99
CFLAGS	+= -D_GNU_SOURCE

.PHONY		:	all clean distclean
.SUFFIXES	:	.c .o

ifeq ($(PREFIX),)
    PREFIX := /usr/local
endif

all: $(NAME)

$(NAME): $(OBJS) Makefile
	$(CC) $(CFLAGS) $(LDLIBS) -o $(NAME) $(OBJS) $(LFLAGS)

.c.o: $(HEADERS)
	$(CC) $(INCDIRS) $(CFLAGS) -c $*.c

install:
	install -d $(DESTDIR)$(PREFIX)/usr/lib/
	install -m 755 wmidump $(DESTDIR)$(PREFIX)/usr/lib/wmidump
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 755 wmi_dump $(DESTDIR)$(PREFIX)/bin/wmi_dump
clean:
	find . \( -name "*.o" -o -name "*~" -o -name "#*#" \) -exec rm {} \;

distclean:	clean
	rm -f $(NAME)

