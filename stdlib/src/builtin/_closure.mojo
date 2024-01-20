# ===----------------------------------------------------------------------=== #
#
# This file is Modular Inc proprietary.
#
# ===----------------------------------------------------------------------=== #


@register_passable
struct __ParameterClosureCaptureList[fn_type: AnyRegType, fn_ref: fn_type]:
    var value: __mlir_type.`!kgen.pointer<none>`

    # Parameter closure invariant requires this function be marked 'capturing'.
    @parameter
    @always_inline
    fn __init__() -> Self:
        return Self {
            value: __mlir_op.`kgen.capture_list.create`[callee=fn_ref]()
        }

    @always_inline
    fn __copyinit__(existing: Self) -> Self:
        return Self {
            value: __mlir_op.`kgen.capture_list.copy`[callee=fn_ref](
                existing.value
            )
        }

    @always_inline
    fn __del__(owned self):
        __mlir_op.`pop.aligned_free`(self.value)

    @always_inline("nodebug")
    fn expand(self):
        __mlir_op.`kgen.capture_list.expand`(self.value)


fn __closure_wrapper_noop_dtor(
    owned self: __mlir_type.`!kgen.pointer<none>`, /
):
    pass


fn __closure_wrapper_noop_copy(
    owned other: __mlir_type.`!kgen.pointer<none>`, /
) -> __mlir_type.`!kgen.pointer<none>`:
    return __mlir_attr.`#interp.pointer<0> : !kgen.pointer<none>`
