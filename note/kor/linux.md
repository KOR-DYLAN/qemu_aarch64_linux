# Directory structure of Linux kernel sources
- arch
  - arch 하부 디렉토리에는 아키텍처별로 동작하는 커널 코드가 있다.
      |arch|desc|
      |---|---|
      |arm|32bit 계열 ARM 아키텍터 코드가 있다.|
      |arm64|64bit 계열 ARM 아키텍터 코드가 있다.|
      |x86|인텔 x86 아키텍처 코드가 있다.|
- include
  - include에는 kernel build에 필요한 header 파일이 있다.
- Documentation
  - kernel 기술 문서가 있는 폴더로, kernel system에 대한 기본 동작을 설명하는 문서를 찾을 수 있다.
  - kernel 개발장를 대상으로 하는 문서이므로 kernel에 대한 기본지식이 없으면 이해하기 어려울 수 있다.
- kernel
  - kernel의 핵심 code가 있는 디렉토리로, 다음과 같은 하위 디렉토리로 구성된다.
      |name|desc|
      |---|---|
      |irq|인터럽트 관련 코드|
      |sched|스케쥴링 관련 코드|
      |power|kernel power management 관련 코드|
      |locking|kernel 동기화 관련 코드|
      |printk|kernel console 관련 코드|
      |ftrace|ftrace 관련 코드|
  - 위 디렉토리에는 아키텍처와 무관한 kernel 공통 코드가 있으며, 아키텍처별로 동작하는 kernel 코드는 'arch/*/kernel'에 위치한다.
- mm
  - Memory Managerment의 약자로 가상 메로리 및 페이징 관련 코드가 있다.
  - 아키텍처별로 동작하는 메모리 관리 코드는 'arch/*/mm'에 위치한다.
- drivers
  - 모든 system device driver 코드가 여기에 위치한다.
  - 하부 디렉토리에 driver 종류별로 구성된 sub-system의 code가 존재한다.
- fs
  - file system 관련 코드가 여기에 위치한다.
  - 공통 code는 이 디렉토리에 위치하며, file-system type 별로 세분화된 code는 해당 file-system 이름으로 작성된 디렉토리에 위치한다.
- lib
  - kernel에서 제곤하는 library 코드가 여기에 위친한다.
  - 아키텍처에 종속적인 library 코드는 'arch/*/lib'에 위치한다.

# GNU Binary Utility
|Utility| Function|
|-|-|
|objdump| 라이브러리나 ELF(Executable and Linkable Foramt) 형식의 파일을 어셈블리어로 출력|
|as|어셈블러|
|ld|링커|
|addr2line|주소를 파일과 라인으로 출력|
|rm|오브젝트 파일의 심벌을 출력|
|readelf|ELF파일의 내용을 출력

## objdump
### 1. linux elf 파일로 부터 header 정보 추출
```sh
[qemu_aarch64_linux]
export OD=aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-objdump
$OD -x build/linux/vmlinux | more > vmlinux.hdr
```
- header 상단의 정보를 참조하면 아키텍처와 start(base) address 정보를 알 수 있음. 
    ```
    [qemu_aarch64_linux/vmlinux.hdr]
    build/linux/vmlinux:     file format elf64-littleaarch64
    build/linux/vmlinux
    architecture: aarch64, flags 0x00000150:
    HAS_SYMS, DYNAMIC, D_PAGED
    start address 0xffffffc008000000
    ...
    ```
- 다음과 같이 elf를 구성 하고 있는 요약된 section 정보를 볼 수 있음.
    ```
    [qemu_aarch64_linux/vmlinux.hdr]
    ...
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .head.text    00010000  ffffffc008000000  ffffffc008000000  00010000  2**16
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      1 .text         00a1e000  ffffffc008010000  ffffffc008010000  00020000  2**16
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      2 .rodata       0024a1de  ffffffc008a30000  ffffffc008a30000  00a40000  2**12
                      CONTENTS, ALLOC, LOAD, DATA
      3 .pci_fixup    000027d0  ffffffc008c7a1e0  ffffffc008c7a1e0  00c8a1e0  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      4 __ksymtab     0000ee80  ffffffc008c7c9b0  ffffffc008c7c9b0  00c8c9b0  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
    ...
    ```

- 다음과 같이 elf를 구성 하고 있는 요약된 section 정보를 볼 수 있음.
    ```
    [qemu_aarch64_linux/vmlinux.hdr]
    ...
    Sections:
    Idx Name          Size      VMA               LMA               File off  Algn
      0 .head.text    00010000  ffffffc008000000  ffffffc008000000  00010000  2**16
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      1 .text         00a1e000  ffffffc008010000  ffffffc008010000  00020000  2**16
                      CONTENTS, ALLOC, LOAD, READONLY, CODE
      2 .rodata       0024a1de  ffffffc008a30000  ffffffc008a30000  00a40000  2**12
                      CONTENTS, ALLOC, LOAD, DATA
      3 .pci_fixup    000027d0  ffffffc008c7a1e0  ffffffc008c7a1e0  00c8a1e0  2**4
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
      4 __ksymtab     0000ee80  ffffffc008c7c9b0  ffffffc008c7c9b0  00c8c9b0  2**2
                      CONTENTS, ALLOC, LOAD, READONLY, DATA
    ...
    ```

- 다음과 같이 elf를 구성 하고 있는 요약된 section 정보를 볼 수 있음.
    ```
    [qemu_aarch64_linux/vmlinux.hdr]
    ...
    SYMBOL TABLE:
    ffffffc008000000 l    d  .head.text	0000000000000000 .head.text
    ffffffc008010000 l    d  .text	0000000000000000 .text
    ffffffc008a30000 l    d  .rodata	0000000000000000 .rodata
    ffffffc008c7a1e0 l    d  .pci_fixup	0000000000000000 .pci_fixup
    ffffffc008c7c9b0 l    d  __ksymtab	0000000000000000 __ksymtab
    ...
    ffffffc008902f00 l     F .text	000000000000012c ip_tunnel_update
    ffffffc00920454f l     O .data	0000000000000001 __already_done.0
    0000000000000000 l    df *ABS*	0000000000000000 sysctl_net_ipv4.c
    ...
    ffffffc008812dc0 g     F .text	0000000000000130 netdev_offload_xstats_get
    ffffffc0084c9198 g     F .text	00000000000000d8 blk_mq_init_tags
    ffffffc008396d70 g     F .text	00000000000001f8 ext4_xattr_ibody_get
    ...
    ```
    - symbol table을 보는 방법은 다음과 같음:
      |address|type|section|size|name|
      |---|---|---|---|---|
      |ffffffc008000000|l    d|.head.text|0000000000000000|.head.text|
      |ffffffc008902f00|l     F|.text|000000000000012c|ip_tunnel_update|
      |ffffffc00920454f|l     O|.data|0000000000000001|__already_done.0|
      |0000000000000000|l    df|*ABS*|0000000000000000|sysctl_net_ipv4.c|
      |ffffffc008812dc0|g     F|.text|0000000000000130|netdev_offload_xstats_get|

      |name|desc|
      |---|---|
      |address|symbol의 시작 주소|
      |type|symbol의 type <br> [l]: local symbol <br> [d]: data tytpe <br> [F]: function <br> [df]: data section에서 사용되는 local 변수 <br> [O]: Object|
      |section|symbol이 속한 section|
      |size|symbol의 크기|
      |name|symbol 이름|

### 2. linux elf 파일로 부터 assembly 추출   
```sh
[qemu_aarch64_linux]
export OD=aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-objdump
$OD -d build/linux/vmlinux | more > vmlinux.asm
```
- 위와 같은 방법으로 elf 전체의 assembly를 추출하게되면 수백만 라인이 되기 때문에 분석에 어려움이 있다.
- 아래와 같은 방법으로 부분적으로 assembly를 추출하는 것이 좀더 효율적인 방법일 수 있다.
  ```sh
  [qemu_aarch64_linux]
  export OD=aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-objdump
  $OD --start=[start address] --stop=[end address] -d build/linux/vmlinux > vmlinux.asm
  ```
- kernel build를 하면 자동으로 생성되는 'System.map'을 통해 symbol의 address를 확인 할 수도 있지만, symbol의 크기까지는 알 수 없다.  
위에서 확인 한 header 정보를 통해 symbol의 크기까지 알 수 있다.
  ```sh
  [qemu_aarch64_linux/vmlinux.hdr]
  ...
  ffffffc0082ab310 g     F .text	00000000000000d8 seq_printf
  ...
  export OD=aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-objdump
  $OD --start=0xffffffc0082ab310 --stop=0xffffffc0082ab3e8 -d build/linux/vmlinux > vmlinux.asm

  [qemu_aarch64_linux/vmlinux.asm]
  ...
  ffffffc0082ab310 <seq_printf>:
  ffffffc0082ab310:	d503201f 	nop
  ffffffc0082ab314:	d503201f 	nop
  ffffffc0082ab318:	d503233f 	paciasp
  ffffffc0082ab31c:	a9b47bfd 	stp	x29, x30, [sp, #-192]!
  ffffffc0082ab320:	d5384108 	mrs	x8, sp_el0
  ffffffc0082ab324:	910003fd 	mov	x29, sp
  ffffffc0082ab328:	f9000bf3 	str	x19, [sp, #16]
  ...
  ```

# Intterupt 정보 파악하는 방법
- target machine 에서 '/proc/interrupts'을 통해 현재 machine의 interrupt 속성 정보를 알 수 있다.
- 아래는 cat 명령어로 '/proc/interrupts'의 정보를 출력하는 예 이다.
  ```sh
  # cat /proc/interrupts
             CPU0       CPU1       CPU2       CPU3
   11:       4774       6755       7177       7836 GIC-0  27 Level     arch_timer
   13:         23          0          0          0 GIC-0  33 Level     uart-pl011
   14:        384          0          0          0 GIC-0  78 Edge      virtio0
   15:         49          0          0          0 GIC-0  79 Edge      virtio1
   16:          0          0          0          0 GIC-0  23 Level     arm-pmu
  IPI0:        43         68         73         76       Rescheduling interrupts
  IPI1:      2050       1136       1043        905       Function call interrupts
  IPI2:         0          0          0          0       CPU stop interrupts
  IPI3:         0          0          0          0       CPU stop (for crash dump) interrupts
  IPI4:         0          0          0          0       Timer broadcast interrupts
  IPI5:         0          0          0          0       IRQ work interrupts
  IPI6:         0          0          0          0       CPU wake-up interrupts
  ```
- 위 정보를 출력 할 때 'show_interrupts' 함수가 호출되며, 이 함수의 parameter를 이용하면 좀 더 자세한 정보를 얻을 수 있다.
- 아래는 'show_interrupts' 함수의 parameter를 이용하는 patch code이다.<br>
  patch code에서 parameter는 아래와 같은 정보를 출력 한다.<br>
  |name|desc|
  |---|---|
  |current->comm|현재 실행 중인 process|
  |action_p->irq|Interrupt 번호|
  |action_p->name|Interrupt 이름|
  |action_p->handler|Interrupt Handler 이름|
  ```diff
  diff --git a/linux/kernel/irq/proc.c b/linux/kernel/irq/proc.c
  index 623b8136e..0179c5550 100644
  --- a/linux/kernel/irq/proc.c
  +++ b/linux/kernel/irq/proc.c
  @@ -43,6 +43,20 @@ enum {
          EFFECTIVE_LIST,
   };
   
  +static noinline void qemu_custom_get_interrupt_info(struct irqaction *action_p)
  +{
  +       unsigned int irq_num = action_p->irq;
  +       void *irq_handler = NULL;
  +
  +       if (action_p->handler) {
  +               irq_handler = (void *)action_p->handler;
  +       }
  +
  +       if (irq_handler) {
  +               trace_printk("[%s] %d:%s, irq_handler: %pS \n", current->comm, irq_num,   action_p->name, irq_handler);
  +       }
  +}
  +
   static int show_irq_affinity(int type, struct seq_file *m)
   {
          struct irq_desc *desc = irq_to_desc((long)m->private);
  @@ -524,6 +538,7 @@ int show_interrupts(struct seq_file *p, void *v)
   
          action = desc->action;
          if (action) {
  +               qemu_custom_get_interrupt_info(action);
                  seq_printf(p, "  %s", action->name);
                  while ((action = action->next) != NULL)
                          seq_printf(p, ", %s", action->name);
  ```
- patch code 적용을 완료 했으면 build 후 machine을 재실행 한다.

## ftrace
- linux kernel debugging tool 중 하나 인 ftrace에 대해 간단히 설명한다.
- 다음은 debugfs에 정의된 ftrace 관련 파일에 대해 설명 합니다.
  |path[ /sys/kernel/debug/tracing/ ]|desc|
  |---|---|
  |tracing_on|ftrace의 활성|
  |set_ftrace_filter|- trace 하고자 하는 함수를 지정.<br>- current_tracer을 'function'이나 'fucntion_graph'로 설정해야 유효.<br>- 'available_filter_functions'에 존재하는 함수들만 trace 가능.|
  |current_tracer| <br> [nop]: ftrace event만 출력. <br> [function]: set_ftrace_filter로 지정한 함수를 누가 호출하는지 출력. <br> [fucntion_graph]: 함수 실행 시간과 세부 호출 정보를 그래프 포맷으로 출력.<br>|
  |options/func_stack_trace|- call stack 출력<br>- current_tracer을 'function'이나 'fucntion_graph'로 설정해야 유효.|
  |options/sym-offset|- call stack에 대한 symbol offset 출력<br>- current_tracer을 'function'이나 'fucntion_graph'로 설정해야 유효.|
  |events/enable|ftrace events의 활성|
  |events/raw_syscalls/enable||
  |events/sched/sched_wakeup/enable|프로세스 sleep and wake-up 정보|
  |events/sched/sched_switch/enable|contex switching 정보|
  |events/irq/irq_handler_entry/enable|interrupt 번호, 이름, 발생한 시각 출력|
  |events/irq/irq_handler/exit|interrupt handler 완료|
