(** Atmel's ATDF (AVR Target Description Format) files parsing library.

    This library provides type-safe parsing of Microchip/Atmel ATDF XML files,
    which describe the hardware peripherals, memory map, registers, interrupts,
    and pinouts of AVR microcontrollers. *)

module File = File
(** Top-level ATDF file container. *)

(** {2 Variants section} *)

module Variant = Variant
(** Device variant (ordering code, package, electrical characteristics). *)

(** {2 Devices section} *)

module Device = Device
(** Device definition. *)

(** {3 Memory} *)

module Address_space = Address_space
(** Named address space (prog, data, eeprom, fuses, etc.). *)

module Memory_segment = Memory_segment
(** Individual memory region within an address space. *)

(** {3 Peripherals} *)

module Peripheral_module = Peripheral_module
(** Peripheral module with one or more hardware instances. *)

module Interface = Interface
(** Programming/debug interface definition. *)

module Interrupt = Interrupt
(** Interrupt vector definition. *)

module Property_group = Property_group
(** Programmer-specific configuration properties. *)

module Register = Register
(** Hardware register with bitfield definitions. *)

(** {2 Modules section} *)

module Module = Module
(** Register and value group definitions referenced by peripheral instances. *)

(** {2 Pinouts section} *)

module Pinout = Pinout
(** Physical package pin mapping. *)
