set(GLSL_OPTIMIZER "${bgfx_SOURCE_DIR}/3rdparty/glsl-optimizer/")
set(FCPP_DIR "${bgfx_SOURCE_DIR}/3rdparty/fcpp/")
set(GLSLANG "${bgfx_SOURCE_DIR}/3rdparty/glslang/")
set(SPIRV_CROSS "${bgfx_SOURCE_DIR}/3rdparty/spirv-cross/")
set(SPIRV_HEADERS "${bgfx_SOURCE_DIR}/3rdparty/spirv-headers/")
set(SPIRV_TOOLS "${bgfx_SOURCE_DIR}/3rdparty/spirv-tools/")


# ------------------------------------------------------------------------------
# SPIRV-OPT
# ------------------------------------------------------------------------------

add_library(spirv_opt STATIC
    ${SPIRV_TOOLS}source/assembly_grammar.cpp
    ${SPIRV_TOOLS}source/binary.cpp
    ${SPIRV_TOOLS}source/diagnostic.cpp
    ${SPIRV_TOOLS}source/disassemble.cpp
    ${SPIRV_TOOLS}source/enum_string_mapping.cpp
    ${SPIRV_TOOLS}source/ext_inst.cpp
    ${SPIRV_TOOLS}source/extensions.cpp
    ${SPIRV_TOOLS}source/libspirv.cpp
    ${SPIRV_TOOLS}source/name_mapper.cpp
    ${SPIRV_TOOLS}source/opcode.cpp
    ${SPIRV_TOOLS}source/operand.cpp
    ${SPIRV_TOOLS}source/parsed_operand.cpp
    ${SPIRV_TOOLS}source/print.cpp
    ${SPIRV_TOOLS}source/software_version.cpp
    ${SPIRV_TOOLS}source/spirv_endian.cpp
    ${SPIRV_TOOLS}source/spirv_optimizer_options.cpp
    ${SPIRV_TOOLS}source/spirv_reducer_options.cpp
    ${SPIRV_TOOLS}source/spirv_target_env.cpp
    ${SPIRV_TOOLS}source/spirv_validator_options.cpp
    ${SPIRV_TOOLS}source/table.cpp
    ${SPIRV_TOOLS}source/text.cpp
    ${SPIRV_TOOLS}source/text_handler.cpp
    ${SPIRV_TOOLS}source/util/bit_vector.cpp
    ${SPIRV_TOOLS}source/util/parse_number.cpp
    ${SPIRV_TOOLS}source/util/string_utils.cpp
    ${SPIRV_TOOLS}source/val/basic_block.cpp
    ${SPIRV_TOOLS}source/val/construct.cpp
    ${SPIRV_TOOLS}source/val/function.cpp
    ${SPIRV_TOOLS}source/val/instruction.cpp
    ${SPIRV_TOOLS}source/val/validate.cpp
    ${SPIRV_TOOLS}source/val/validate_adjacency.cpp
    ${SPIRV_TOOLS}source/val/validate_annotation.cpp
    ${SPIRV_TOOLS}source/val/validate_arithmetics.cpp
    ${SPIRV_TOOLS}source/val/validate_atomics.cpp
    ${SPIRV_TOOLS}source/val/validate_barriers.cpp
    ${SPIRV_TOOLS}source/val/validate_bitwise.cpp
    ${SPIRV_TOOLS}source/val/validate_builtins.cpp
    ${SPIRV_TOOLS}source/val/validate_capability.cpp
    ${SPIRV_TOOLS}source/val/validate_cfg.cpp
    ${SPIRV_TOOLS}source/val/validate_composites.cpp
    ${SPIRV_TOOLS}source/val/validate_constants.cpp
    ${SPIRV_TOOLS}source/val/validate_conversion.cpp
    ${SPIRV_TOOLS}source/val/validate_debug.cpp
    ${SPIRV_TOOLS}source/val/validate_decorations.cpp
    ${SPIRV_TOOLS}source/val/validate_derivatives.cpp
    ${SPIRV_TOOLS}source/val/validate_execution_limitations.cpp
    ${SPIRV_TOOLS}source/val/validate_extensions.cpp
    ${SPIRV_TOOLS}source/val/validate_function.cpp
    ${SPIRV_TOOLS}source/val/validate_id.cpp
    ${SPIRV_TOOLS}source/val/validate_image.cpp
    ${SPIRV_TOOLS}source/val/validate_instruction.cpp
    ${SPIRV_TOOLS}source/val/validate_interfaces.cpp
    ${SPIRV_TOOLS}source/val/validate_layout.cpp
    ${SPIRV_TOOLS}source/val/validate_literals.cpp
    ${SPIRV_TOOLS}source/val/validate_logicals.cpp
    ${SPIRV_TOOLS}source/val/validate_memory.cpp
    ${SPIRV_TOOLS}source/val/validate_memory_semantics.cpp
    ${SPIRV_TOOLS}source/val/validate_misc.cpp
    ${SPIRV_TOOLS}source/val/validate_mode_setting.cpp
    ${SPIRV_TOOLS}source/val/validate_non_uniform.cpp
    ${SPIRV_TOOLS}source/val/validate_primitives.cpp
    ${SPIRV_TOOLS}source/val/validate_ray_query.cpp
    ${SPIRV_TOOLS}source/val/validate_scopes.cpp
    ${SPIRV_TOOLS}source/val/validate_small_type_uses.cpp
    ${SPIRV_TOOLS}source/val/validate_type.cpp
    ${SPIRV_TOOLS}source/val/validation_state.cpp

    ${SPIRV_TOOLS}source/opt/aggressive_dead_code_elim_pass.cpp
    ${SPIRV_TOOLS}source/opt/amd_ext_to_khr.cpp
    ${SPIRV_TOOLS}source/opt/basic_block.cpp
    ${SPIRV_TOOLS}source/opt/block_merge_pass.cpp
    ${SPIRV_TOOLS}source/opt/block_merge_util.cpp
    ${SPIRV_TOOLS}source/opt/build_module.cpp
    ${SPIRV_TOOLS}source/opt/ccp_pass.cpp
    ${SPIRV_TOOLS}source/opt/cfg.cpp
    ${SPIRV_TOOLS}source/opt/cfg_cleanup_pass.cpp
    ${SPIRV_TOOLS}source/opt/code_sink.cpp
    ${SPIRV_TOOLS}source/opt/combine_access_chains.cpp
    ${SPIRV_TOOLS}source/opt/compact_ids_pass.cpp
    ${SPIRV_TOOLS}source/opt/composite.cpp
    ${SPIRV_TOOLS}source/opt/constants.cpp
    ${SPIRV_TOOLS}source/opt/const_folding_rules.cpp
    ${SPIRV_TOOLS}source/opt/control_dependence.cpp
    ${SPIRV_TOOLS}source/opt/convert_to_half_pass.cpp
    ${SPIRV_TOOLS}source/opt/convert_to_sampled_image_pass.cpp
    ${SPIRV_TOOLS}source/opt/copy_prop_arrays.cpp
    ${SPIRV_TOOLS}source/opt/dataflow.cpp
    ${SPIRV_TOOLS}source/opt/dead_branch_elim_pass.cpp
    ${SPIRV_TOOLS}source/opt/dead_insert_elim_pass.cpp
    ${SPIRV_TOOLS}source/opt/dead_variable_elimination.cpp
    ${SPIRV_TOOLS}source/opt/debug_info_manager.cpp
    ${SPIRV_TOOLS}source/opt/decoration_manager.cpp
    ${SPIRV_TOOLS}source/opt/def_use_manager.cpp
    ${SPIRV_TOOLS}source/opt/desc_sroa.cpp
    ${SPIRV_TOOLS}source/opt/desc_sroa_util.cpp
    ${SPIRV_TOOLS}source/opt/dominator_analysis.cpp
    ${SPIRV_TOOLS}source/opt/dominator_tree.cpp
    ${SPIRV_TOOLS}source/opt/eliminate_dead_constant_pass.cpp
    ${SPIRV_TOOLS}source/opt/eliminate_dead_functions_pass.cpp
    ${SPIRV_TOOLS}source/opt/eliminate_dead_functions_util.cpp
    ${SPIRV_TOOLS}source/opt/eliminate_dead_input_components_pass.cpp
    ${SPIRV_TOOLS}source/opt/eliminate_dead_members_pass.cpp
    ${SPIRV_TOOLS}source/opt/feature_manager.cpp
    ${SPIRV_TOOLS}source/opt/fix_func_call_arguments.cpp
    ${SPIRV_TOOLS}source/opt/fix_storage_class.cpp
    ${SPIRV_TOOLS}source/opt/flatten_decoration_pass.cpp
    ${SPIRV_TOOLS}source/opt/fold.cpp
    ${SPIRV_TOOLS}source/opt/folding_rules.cpp
    ${SPIRV_TOOLS}source/opt/fold_spec_constant_op_and_composite_pass.cpp
    ${SPIRV_TOOLS}source/opt/freeze_spec_constant_value_pass.cpp
    ${SPIRV_TOOLS}source/opt/function.cpp
    ${SPIRV_TOOLS}source/opt/graphics_robust_access_pass.cpp
    ${SPIRV_TOOLS}source/opt/if_conversion.cpp
    ${SPIRV_TOOLS}source/opt/inline_exhaustive_pass.cpp
    ${SPIRV_TOOLS}source/opt/inline_opaque_pass.cpp
    ${SPIRV_TOOLS}source/opt/inline_pass.cpp
    ${SPIRV_TOOLS}source/opt/instruction.cpp
    ${SPIRV_TOOLS}source/opt/instruction_list.cpp
    ${SPIRV_TOOLS}source/opt/instrument_pass.cpp
    ${SPIRV_TOOLS}source/opt/inst_bindless_check_pass.cpp
    ${SPIRV_TOOLS}source/opt/inst_buff_addr_check_pass.cpp
    ${SPIRV_TOOLS}source/opt/inst_debug_printf_pass.cpp
    ${SPIRV_TOOLS}source/opt/interface_var_sroa.cpp
    ${SPIRV_TOOLS}source/opt/interp_fixup_pass.cpp
    ${SPIRV_TOOLS}source/opt/ir_context.cpp
    ${SPIRV_TOOLS}source/opt/ir_loader.cpp
    ${SPIRV_TOOLS}source/opt/licm_pass.cpp
    ${SPIRV_TOOLS}source/opt/local_access_chain_convert_pass.cpp
    ${SPIRV_TOOLS}source/opt/local_redundancy_elimination.cpp
    ${SPIRV_TOOLS}source/opt/local_single_block_elim_pass.cpp
    ${SPIRV_TOOLS}source/opt/local_single_store_elim_pass.cpp
    ${SPIRV_TOOLS}source/opt/loop_dependence.cpp
    ${SPIRV_TOOLS}source/opt/loop_dependence_helpers.cpp
    ${SPIRV_TOOLS}source/opt/loop_descriptor.cpp
    ${SPIRV_TOOLS}source/opt/loop_fission.cpp
    ${SPIRV_TOOLS}source/opt/loop_fusion.cpp
    ${SPIRV_TOOLS}source/opt/loop_fusion_pass.cpp
    ${SPIRV_TOOLS}source/opt/loop_peeling.cpp
    ${SPIRV_TOOLS}source/opt/loop_unroller.cpp
    ${SPIRV_TOOLS}source/opt/loop_unswitch_pass.cpp
    ${SPIRV_TOOLS}source/opt/loop_utils.cpp
    ${SPIRV_TOOLS}source/opt/mem_pass.cpp
    ${SPIRV_TOOLS}source/opt/merge_return_pass.cpp
    ${SPIRV_TOOLS}source/opt/module.cpp
    ${SPIRV_TOOLS}source/opt/optimizer.cpp
    ${SPIRV_TOOLS}source/opt/pass.cpp
    ${SPIRV_TOOLS}source/opt/pass_manager.cpp
    ${SPIRV_TOOLS}source/opt/pch_source_opt.cpp
    ${SPIRV_TOOLS}source/opt/private_to_local_pass.cpp
    ${SPIRV_TOOLS}source/opt/propagator.cpp
    ${SPIRV_TOOLS}source/opt/reduce_load_size.cpp
    ${SPIRV_TOOLS}source/opt/redundancy_elimination.cpp
    ${SPIRV_TOOLS}source/opt/register_pressure.cpp
    ${SPIRV_TOOLS}source/opt/relax_float_ops_pass.cpp
    ${SPIRV_TOOLS}source/opt/remove_dontinline_pass.cpp
    ${SPIRV_TOOLS}source/opt/remove_duplicates_pass.cpp
    ${SPIRV_TOOLS}source/opt/remove_unused_interface_variables_pass.cpp
    ${SPIRV_TOOLS}source/opt/replace_desc_array_access_using_var_index.cpp
    ${SPIRV_TOOLS}source/opt/replace_invalid_opc.cpp
    ${SPIRV_TOOLS}source/opt/scalar_analysis.cpp
    ${SPIRV_TOOLS}source/opt/scalar_analysis_simplification.cpp
    ${SPIRV_TOOLS}source/opt/scalar_replacement_pass.cpp
    ${SPIRV_TOOLS}source/opt/set_spec_constant_default_value_pass.cpp
    ${SPIRV_TOOLS}source/opt/simplification_pass.cpp
    ${SPIRV_TOOLS}source/opt/spread_volatile_semantics.cpp
    ${SPIRV_TOOLS}source/opt/ssa_rewrite_pass.cpp
    ${SPIRV_TOOLS}source/opt/strength_reduction_pass.cpp
    ${SPIRV_TOOLS}source/opt/strip_debug_info_pass.cpp
    ${SPIRV_TOOLS}source/opt/strip_nonsemantic_info_pass.cpp
    ${SPIRV_TOOLS}source/opt/struct_cfg_analysis.cpp
    ${SPIRV_TOOLS}source/opt/types.cpp
    ${SPIRV_TOOLS}source/opt/type_manager.cpp
    ${SPIRV_TOOLS}source/opt/unify_const_pass.cpp
    ${SPIRV_TOOLS}source/opt/upgrade_memory_model.cpp
    ${SPIRV_TOOLS}source/opt/value_number_table.cpp
    ${SPIRV_TOOLS}source/opt/vector_dce.cpp
    ${SPIRV_TOOLS}source/opt/workaround1209.cpp
    ${SPIRV_TOOLS}source/opt/wrap_opkill.cpp

    ${SPIRV_TOOLS}source/reduce/change_operand_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/change_operand_to_undef_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/conditional_branch_to_simple_conditional_branch_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/conditional_branch_to_simple_conditional_branch_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/merge_blocks_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/merge_blocks_reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/operand_to_const_reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/operand_to_dominating_id_reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/operand_to_undef_reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/pch_source_reduce.cpp
    ${SPIRV_TOOLS}source/reduce/reducer.cpp
    ${SPIRV_TOOLS}source/reduce/reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/reduction_pass.cpp
    ${SPIRV_TOOLS}source/reduce/reduction_util.cpp
    ${SPIRV_TOOLS}source/reduce/remove_block_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/remove_block_reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/remove_function_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/remove_function_reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/remove_instruction_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/remove_selection_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/remove_selection_reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/remove_struct_member_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/remove_unused_instruction_reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/remove_unused_struct_member_reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/simple_conditional_branch_to_branch_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/simple_conditional_branch_to_branch_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/structured_construct_to_block_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/structured_construct_to_block_reduction_opportunity_finder.cpp
    ${SPIRV_TOOLS}source/reduce/structured_loop_to_selection_reduction_opportunity.cpp
    ${SPIRV_TOOLS}source/reduce/structured_loop_to_selection_reduction_opportunity_finder.cpp
)

target_include_directories(spirv_opt
    PUBLIC
        ${SPIRV_TOOLS}include
        ${SPIRV_TOOLS}include/generated
        ${SPIRV_HEADERS}include
    PRIVATE
        ${SPIRV_TOOLS}
        ${SPIRV_TOOLS}source
)

if(MSVC)
    target_compile_options(spirv_opt PRIVATE
        /wd4127
        /wd4389
        /wd4702
        /wd4706
    )
endif()

if(APPLE OR LINUX OR MINGW)
    target_compile_options(spirv_opt PRIVATE
        -Wno-misleading-indentation
        -Wno-switch
    )
endif()

set_target_properties(spirv_opt PROPERTIES
    FOLDER "shaderc"
)


# ------------------------------------------------------------------------------
# SPIRV-CROSS
# ------------------------------------------------------------------------------

add_library(spirv_cross STATIC
    ${SPIRV_CROSS}spirv.hpp
    ${SPIRV_CROSS}spirv_cfg.cpp
    ${SPIRV_CROSS}spirv_cfg.hpp
    ${SPIRV_CROSS}spirv_common.hpp
    ${SPIRV_CROSS}spirv_cpp.cpp
    ${SPIRV_CROSS}spirv_cpp.hpp
    ${SPIRV_CROSS}spirv_cross.cpp
    ${SPIRV_CROSS}spirv_cross.hpp
    ${SPIRV_CROSS}spirv_cross_parsed_ir.cpp
    ${SPIRV_CROSS}spirv_cross_parsed_ir.hpp
    ${SPIRV_CROSS}spirv_cross_util.cpp
    ${SPIRV_CROSS}spirv_cross_util.hpp
    ${SPIRV_CROSS}spirv_glsl.cpp
    ${SPIRV_CROSS}spirv_glsl.hpp
    ${SPIRV_CROSS}spirv_hlsl.cpp
    ${SPIRV_CROSS}spirv_hlsl.hpp
    ${SPIRV_CROSS}spirv_msl.cpp
    ${SPIRV_CROSS}spirv_msl.hpp
    ${SPIRV_CROSS}spirv_parser.cpp
    ${SPIRV_CROSS}spirv_parser.hpp
    ${SPIRV_CROSS}spirv_reflect.cpp
    ${SPIRV_CROSS}spirv_reflect.hpp
)

target_include_directories(spirv_cross PUBLIC
    ${SPIRV_CROSS}include
)

target_compile_definitions(spirv_cross PUBLIC
    SPIRV_CROSS_EXCEPTIONS_TO_ASSERTIONS
)

if(MSVC)
    target_compile_options(spirv_cross PRIVATE
        /wd4018
        /wd4245
        /wd4706
        /wd4715
    )
endif()

if(APPLE OR LINUX OR MINGW)
    target_compile_options(spirv_opt PRIVATE
        -Wno-type-limits
    )
endif()

set_target_properties(spirv_cross PROPERTIES
    FOLDER "shaderc"
)
