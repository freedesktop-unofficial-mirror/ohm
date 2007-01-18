#!/bin/sh

rm massif.*
killall ohmd

valgrind --tool=massif --format=html --depth=10 \
	 --alloc-fn=g_malloc --alloc-fn=g_realloc \
	 --alloc-fn=g_try_malloc --alloc-fn=g_malloc0 --alloc-fn=g_mem_chunk_alloc \
	 ./ohmd --no-daemon --timed-exit

#massif uses the pid file, which is hard to process.
mv massif.*.html massif.html
mv massif.*.ps massif.ps
#convert to pdf, and make readable by normal users
ps2pdf massif.ps massif.pdf
rm massif.ps
rm massif.html
chmod a+r massif.*
