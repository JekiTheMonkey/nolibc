#ifndef SYS_CALLS_H
#define SYS_CALLS_H

extern int sys_errno;

int sys_read(int fd, void *buf, int buflen);
int sys_write(int fd, const void *buf, int buflen);

#endif // !SYS_CALLS_H
