/*
**  `terraform -version`
**
**  Terraform v1.5.7
**  on linux_amd64
**
**  Outputs from `terraform constole`
*/

/*
** Comments
**/

/*
  Multi-Line Comments
  First Line
  Second Line
*/

// First Line
// Second Line

# First Line
# Second Line

locals {
  /*
  ** Types and Values / Section
  ** Reference: https://developer.hashicorp.com/terraform/language/expressions/types
  **/

  local_null = null
  /*
  > type(local.local_null)
  dynamic

  > local.local_null
  null
  */

  local_bool = true
  /*
  > type(local.local_bool)
  bool

  > local.local_bool
  true

  > !local.local_bool
  false
  */

  local_number = 1
  /*
  > type(local.local_number)
  number

  > local.local_number
  1
  */

  local_number_float = 1.5
  /*
  > type(local.local_number_float)
  number

  > local.local_number_float
  1.5
  */

  local_string = "string"
  /*
  > type(local.local_string)
  string

  > local.local_string
  "string"
  */

  local_tuple = ["list_item_0", "list_item_1", "list_item_2"]
  local_list  = tolist(["list_item_0", "list_item_1", "list_item_2"])
  /*
  > type(local.local_tuple)
  tuple([
      string,
      string,
      string,
  ])

  > type(local.local_list)
  list(string)

  > local.local_tuple
  [
    "list_item_0",
    "list_item_1",
    "list_item_2",
  ]

  > local.local_tuple[0]
  "list_item_0"

  > local.local_tuple.0
  "list_item_0"

  > local.local_tuple[3]
  ╷
  │ Error: Invalid index
  │ 
  │ The given key does not identify an element in this collection value: the given index is greater than or equal to the length of the collection.
  ╵
  */

  local_object = {
    key1 = "value1"
    key2 = "value2"
  }
  local_map = tomap({
    key1 = "value1"
    key2 = "value2"
  })
  /*
  > type(local.local_object)
  object({
      key1: string,
      key2: string,
  })

  > type(local.local_map)
  map(string)

  > local.local_object
  {
    "key1" = "value1"
    "key2" = "value2"
  }

  > local.local_object.key1
  "value1"

  > local.local_object["key1"]
  "value1"
  */

  local_set = toset([
    "set_unique_value_1",
    "set_unique_value_2",
    "set_dublicate_value_1",
    "set_dublicate_value_1",
    "set_dublicate_value_2",
    "set_dublicate_value_2"
  ])
  /*
  > type(local.local_set)
  set(string)

  > local.local_set
  toset([
    "set_dublicate_value_1",
    "set_dublicate_value_2",
    "set_unique_value_1",
    "set_unique_value_2",
  ])

  > local.local_set[0]
  ╷
  │ Error: Invalid index
  │ 
  │ Elements of a set are identified only by their value and don't have any separate index or key to select with, so it's only possible to perform operations across all elements of the set.
  ╵
  */

  local_list_maps = [
    {
      key1 = "value1_1"
      key2 = "value2_1"
    },
    {
      key1 = "value1_2"
      key2 = "value2_2"
    },
    {
      key1 = "value1_3"
      key2 = "value2_3"
    }
  ]
  /*
  > local.local_list_maps[0].key1
  "value1_1"

  > local.local_list_maps.0.key1
  "value1_1"

  > local.local_list_maps[*].key1
  [
    "value1_1",
    "value1_2",
    "value1_3",
  ]

  > local.local_list_maps.*.key1
  [
    "value1_1",
    "value1_2",
    "value1_3",
  ]
  */

  /*
  ** Strings and Templates / Section
  ** Reference: https://developer.hashicorp.com/terraform/language/expressions/strings
  **/

  local_string_oneline = "string"
  /*
  > local.local_string_oneline
  "string"
  */

  local_string_multiline = "First Line\nSecond Line\n"
  /*
  > local.local_string_multiline
  <<EOT
  First Line
  Second Line

  EOT
  */

  local_string_multiline_heredoc = <<EOF
    First Line
    Second Line
  EOF
  /*
  > local.local_string_multiline_heredoc
  <<EOT
      First Line
      Second Line

  EOT
  */

  local_string_multiline_heredoc_indented = <<-EOF
    First Line
    Second Line
  EOF
  /*
  > local.local_string_multiline_heredoc_indented
  <<EOT
  First Line
  Second Line

  EOT
  */

  local_string_multiline_heredoc_template = <<EOF
    First Line
    Second Line
    $${local.local_string_oneline}
    ${local.local_string_oneline}
  EOF
  /*
  > local.local_string_multiline_heredoc_template
  <<EOT
      First Line
      Second Line
      ${local.local_string_oneline}
      string

  EOT
  */

  local_show_string_oneline = true

  # ${<BOOL> ? <VALUE IF TRUE> : <VALUE IF FALSE>}
  local_string_multiline_heredoc_if_ternary_template = <<EOF
    $${local.local_show_string_oneline ? local.local_string_oneline : ""}
    TRUE: (${local.local_show_string_oneline ? local.local_string_oneline : "none"})
    FALSE: (${!local.local_show_string_oneline ? local.local_string_oneline : "none"})
  EOF
  /*
  > local.local_string_multiline_heredoc_if_ternary_template
  <<EOT
      ${local.local_show_string_oneline ? local.local_string_oneline : ""}
      TRUE: (string)
      FALSE: (none)

  EOT
  */

  # %{if <BOOL>}/%{else}/%{endif}
  local_string_multiline_heredoc_if_template = <<EOF
    %%{if local.local_show_string_oneline} local_show_string_oneline==true, $${local.local_string_oneline} %%{else} local_show_string_oneline==false %%{endif}
    TRUE: (%{if local.local_show_string_oneline} local_show_string_oneline==true, ${local.local_string_oneline} %{else} local_show_string_oneline==false %{endif})
    FALSE: (%{if !local.local_show_string_oneline} local_show_string_oneline==true, ${local.local_string_oneline} %{else} local_show_string_oneline==false %{endif})
  EOF
  /*
  > local.local_string_multiline_heredoc_if_template
  <<EOT
      %{if local.local_show_string_oneline} local_show_string_oneline==true, ${local.local_string_oneline} %{else} local_show_string_oneline==false %{endif}
      TRUE: ( local_show_string_oneline==true, string )
      FALSE: ( local_show_string_oneline==false )

  EOT
  */

  # %{for <NAME> in <COLLECTION>} / %{endfor}
  local_strings_set                           = toset(["First Line", "Second Line"])
  local_string_multiline_heredoc_for_template = <<EOF
    %{for line in local.local_strings_set}
      ${line}
    %{endfor}
  EOF
  /*
  > local.local_strings_set
  toset([
    "First Line",
    "Second Line",
  ])
  > local.local_string_multiline_heredoc_for_template
  <<EOT
      
        First Line
      
        Second Line
      

  EOT
  */

  local_string_multiline_heredoc_for_template_stripped = <<EOF
    %{for line in local.local_strings_set~}
      ${line}
    %{endfor~}
  EOF
  /*
  > local.local_string_multiline_heredoc_for_template_stripped
  <<EOT
            First Line
            Second Line
      
  EOT
  */

  local_string_multiline_heredoc_types_template = <<EOF
    $${local.local_bool}: ${local.local_bool}
    $${local.local_number}: ${local.local_number}
    $${local.local_number_float}: ${local.local_number_float}
    $${local.local_string}: ${local.local_string}
    $${local.local_tuple[0]}: ${local.local_tuple[0]}
    $${local.local_tuple.0}: ${local.local_tuple.0} 
    $${local.local_object["key1"]}: ${local.local_object["key1"]}
    $${local.local_object.key1}: ${local.local_object.key1}

    Following iterpolations provokes an error:

    $${local.local_null}
    $${local.local_tuple}
    $${local.local_object}
    $${local.local_set}

    │ Error: Invalid template interpolation value
    │     │ local.local_null is null
    │     │ local.local_set is set of string with 3 elements
    │     │ local.local_object is object with 2 attributes
    │     │ local.local_tuple is tuple with 3 elements
    │ 
    │ Cannot include the given value in a string template: string required.
  EOF
  /*
  > local.local_string_multiline_heredoc_types_template
  <<EOT
      ${local.local_bool}: true
      ${local.local_number}: 1
      ${local.local_number_float}: 1.5
      ${local.local_string}: string
      ${local.local_tuple[0]}: list_item_0
      ${local.local_tuple.0}: list_item_0 
      ${local.local_object["key1"]}: value1
      ${local.local_object.key1}: value1

      Following iterpolations provokes an error:

      ${local.local_null}
      ${local.local_tuple}
      ${local.local_object}
      ${local.local_set}

      │ Error: Invalid template interpolation value
      │     │ local.local_null is null
      │     │ local.local_set is set of string with 3 elements
      │     │ local.local_object is object with 2 attributes
      │     │ local.local_tuple is tuple with 3 elements
      │ 
      │ Cannot include the given value in a string template: string required.

  EOT
  */

  /**
  ** References to Named Values / Section
  ** Reference: https://developer.hashicorp.com/terraform/language/expressions/references
  */

  local_for_local_tuple = local.local_tuple[*]
  /*
  > local.local_for_local_tuple
  [
    "list_item_0",
    "list_item_1",
    "list_item_2",
  ]
  */

  local_for_item_in_local_tuple = local.local_tuple[0]
  /*
  > local.local_for_item_in_local_tuple
  "list_item_0"
  */

  /*
  ** Arithmetic and Logical Operators
  ** Reference: https://developer.hashicorp.com/terraform/language/expressions/operators 
  */

  local_op_number = 2.5

  local_op_number_add = local.local_op_number + 2.5
  /*
  > local.local_op_number_add
  5
  */

  local_op_number_sub = local.local_op_number - 2.5
  /*
  > local.local_op_number_sub
  0
  */

  local_op_number_mul = local.local_op_number * 2.5
  /*
  > local.local_op_number_mul
  6.25
  */

  local_op_number_div = local.local_op_number / 2.5
  /*
  > local.local_op_number_div
  1
  */

  local_op_number_mod = local.local_op_number % 2
  /*
  > local.local_op_number_mod
  0.5
  */

  local_op_number_negative = -local.local_op_number
  /*
  > local.local_op_number_negative
  -2.5
  */

  local_op_equal = local.local_op_number == 2.5
  /*
  > local.local_op_equal
  true
  */

  local_op_not_equal = local.local_op_number != 2.5
  /*
  > local.local_op_not_equal
  false
  */

  local_op_greater = local.local_op_number > 2.5
  /*
  > local.local_op_greater
  false
  */

  local_op_greater_equal = local.local_op_number >= 2.5
  /*
  > local.local_op_greater_equal
  true
  */

  local_op_less = local.local_op_number < 2.5
  /*
  > local.local_op_less
  false
  */

  local_op_less_equal = local.local_op_number <= 2.5
  /*
  > local.local_op_less_equal
  true
  */

  local_op_or = local.local_op_number == 2.5 || local.local_op_number == 3.5
  /*
  > local.local_op_or
  true
  */

  local_op_and = local.local_op_number == 2.5 && local.local_op_number == 3.5
  /*
  > local.local_op_and
  false

  > local.local_op_number == 2.5 && "string"
  ╷
  │ Error: Invalid operand
  │ 
  │ Unsuitable value for right operand: a bool is required.
  ╵

  > local.local_op_number == 3.5 && "string"
  ╷
  │ Error: Invalid operand
  │ 
  │ Unsuitable value for right operand: a bool is required.
  ╵
  */

  local_op_not = !(local.local_op_number == 2.5)
  /*
  > local.local_op_not
  false
  */

  /*
  ** Conditional Expressions
  ** Reference: https://developer.hashicorp.com/terraform/language/expressions/conditionals
  */

  # condition ? true_val : false_val
  local_op_number_if_true = local.local_op_number == 2.5 ? "equal" : "not equal"
  /*
  > local.local_op_number_if_true
  "equal"
  */

  local_op_number_if_false = local.local_op_number == -2.5 ? "equal" : "not equal"
  /*
  > local.local_op_number_if_false
  "not equal"
  */

  /*
  ** for Expressions
  ** Reference: https://developer.hashicorp.com/terraform/language/expressions/for
  */

  # tuples
  local_tuple_for = [for item in local.local_tuple : item]
  /*
  > local.local_tuple_for
  [
    "list_item_0",
    "list_item_1",
    "list_item_2",
  ]
  */

  local_tuple_for_index = [for i, item in local.local_tuple : "${i} - ${item}"]
  /*
  > local.local_tuple_for_index
  [
    "0 - list_item_0",
    "1 - list_item_1",
    "2 - list_item_2",
  ]
  */

  local_set_for_index = [for i, item in local.local_set : "${i} - ${item}"]
  /*
  > local.local_set_for_index
  [
    "set_dublicate_value_1 - set_dublicate_value_1",
    "set_dublicate_value_2 - set_dublicate_value_2",
    "set_unique_value_1 - set_unique_value_1",
    "set_unique_value_2 - set_unique_value_2",
  ]
  */

  local_object_for = [for key, value in local.local_object : "${key} - ${value}"]
  /*
  > local.local_object_for
  [
    "key1 - value1",
    "key2 - value2",
  ]
  */

  # map
  local_set_to_map_for = { for key in local.local_set : key => "value for ${key}" }
  /*
  > local.local_set_to_map_for
  {
    "set_dublicate_value_1" = "value for set_dublicate_value_1"
    "set_dublicate_value_2" = "value for set_dublicate_value_2"
    "set_unique_value_1" = "value for set_unique_value_1"
    "set_unique_value_2" = "value for set_unique_value_2"
  }
  */

  # filtering
  local_set_to_map_for_filtered = { for key in local.local_set : key => "value for ${key}" if length(key) == 18 }
  /*
  > local.local_set_to_map_for_filtered
  {
    "set_unique_value_1" = "value for set_unique_value_1"
    "set_unique_value_2" = "value for set_unique_value_2"
  }
  */

  local_tuple_for_index_filtered = [for i, item in local.local_tuple : "${i} - ${item}" if i == 1]
  /*
  > local.local_tuple_for_index_filtered
  [
    "1 - list_item_1",
  ]
  */

  # grouping

  local_object_for_grouping = {
    "key1" = {
      "key1_1" = "value1_1"
      "key1_2" = "value1_2"
      "group"  = "group1"
    }
    "key2" = {
      "key2_1" = "value2_1"
      "key2_2" = "value2_2"
      "group"  = "group2"
    }
    "key3" = {
      "key3_1" = "value3_1"
      "key3_2" = "value3_2"
      "group"  = "group1"
    }
    "key4" = {
      "key4_1" = "value4_1"
      "key4_2" = "value4_2"
      "group"  = "group2"
    }
  }

  local_object_for_grouped = {
    for key, value in local.local_object_for_grouping :
    value.group => key...
  }

  /*
  ** Built-in Functions
  ** Reference: https://developer.hashicorp.com/terraform/language/functions
  */

  local_ds_number_float         = 2.5
  local_ds_numbers_list         = [1, 2, 3, 4, 5]
  local_ds_number_in_string     = "1"
  local_ds_number_in_string_hex = "FF"

  local_number_and_functions = {
    abs             = abs(local.local_ds_number_float)
    abs_negative    = abs(-local.local_ds_number_float)
    ceil            = ceil(local.local_ds_number_float)
    floor           = floor(local.local_ds_number_float)
    log             = log(local.local_ds_number_float, 2)
    max             = max(1, 2, 3, 4, 5)
    max_list        = max(local.local_ds_numbers_list...)
    min_list        = min(local.local_ds_numbers_list...)
    parseint        = parseint(local.local_ds_number_in_string, 10)
    parseint_hex    = parseint(local.local_ds_number_in_string_hex, 16)
    pow             = pow(local.local_ds_number_float, 2)
    signum          = signum(floor(local.local_ds_number_float))
    signum_zero     = signum(floor(local.local_ds_number_float) - floor(local.local_ds_number_float))
    signum_negative = signum(-floor(local.local_ds_number_float))
  }
  /*
  ** Numeric Functions

  > abs(local.local_ds_number_float)
  2.5

  > abs(-local.local_ds_number_float)
  2.5

  > ceil(local.local_ds_number_float)
  3

  > floor(local.local_ds_number_float)
  2

  > log(local.local_ds_number_float, 2)
  1.3219280948873624

  > max(1, 2, 3, 4, 5)
  5

  > max(local.local_ds_numbers_list...)
  5

  > min(local.local_ds_numbers_list...)
  1

  > parseint(local.local_ds_number_in_string, 10)
  1

  > parseint(local.local_ds_number_in_string_hex, 16)
  255

  > pow(local.local_ds_number_float, 2)
  6.25

  > signum(floor(local.local_ds_number_float))
  1

  > signum(floor(local.local_ds_number_float)-floor(local.local_ds_number_float))
  0

  > signum(-floor(local.local_ds_number_float))
  -1
  */

  local_string_functions = {
    chomp             = chomp(local.local_string_multiline)
    endswith_newline  = endswith(local.local_string_multiline, "Line")
    endswith_chomp    = endswith(chomp(local.local_string_multiline), "Line")
    format            = format("Template string with %.2f%s", local.local_op_number, "Gb")
    formatlist        = formatlist("prefix for %s", local.local_tuple)
    indent            = indent(2, local.local_string_multiline)
    join              = join(";", local.local_tuple)
    lower             = lower(local.local_string_multiline)
    upper             = upper(local.local_string_multiline)
    regex             = regex("([a-z]+)_([a-z]+)_([0-9]+)", local.local_tuple.0)
    regex_join        = regex("([a-z]+)_([a-z]+)_([0-9]+)", join(";", local.local_tuple))
    regexall_join     = regexall("([a-z]+)_([a-z]+)_([0-9]+)", join(";", local.local_tuple))
    replace           = replace(local.local_tuple.0, "list", "tuple")
    split             = split("_", local.local_tuple.0)
    startswith        = startswith(local.local_string_multiline, "First")
    strcontains       = strcontains(local.local_string_multiline, "First")
    strcontains_false = strcontains(local.local_string_multiline, "Third")
    strrev            = strrev(local.local_string)
    substr            = substr(local.local_string_multiline, 6, 4)
    substr_from_end   = substr(local.local_string_multiline, -12, 6)
    title             = title(join(" ", split("_", local.local_tuple.0)))
    trim              = trim(local.local_string_multiline, "\n ")
    trimprefix        = trimprefix(local.local_string_multiline, "First")
    trimsuffix        = trimsuffix(local.local_string_multiline, "Line\n")
    trimspace         = trimspace(local.local_string_multiline)
  }
  /**
  ** String Functions
  
  > chomp(local.local_string_multiline)
  <<EOT
  First Line
  Second Line
  EOT

  > endswith(local.local_string_multiline, "Line")
  false

  > endswith(chomp(local.local_string_multiline), "Line")
  true

  > format("Template string with %.2f%s", local.local_op_number, "Gb")
  "Template string with 2.50Gb"

  > formatlist("prefix for %s", local.local_tuple)
  tolist([
    "prefix for list_item_0",
    "prefix for list_item_1",
    "prefix for list_item_2",
  ])

  > indent(2, local.local_string_multiline)
  <<EOT
  First Line
    Second Line
    
  EOT

  > join(";", local.local_tuple)
  "list_item_0;list_item_1;list_item_2"

  > lower(local.local_string_multiline)
  <<EOT
  first line
  second line

  EOT

  > upper(local.local_string_multiline)
  <<EOT
  FIRST LINE
  SECOND LINE

  EOT

  > regex("([a-z]+)_([a-z]+)_([0-9]+)", local.local_tuple.0)
  [
    "list",
    "item",
    "0",
  ]

  > regex("([a-z]+)_([a-z]+)_([0-9]+)", join(";",local.local_tuple))
  [
    "list",
    "item",
    "0",
  ]

  > regexall("([a-z]+)_([a-z]+)_([0-9]+)", join(";",local.local_tuple))
  tolist([
    [
      "list",
      "item",
      "0",
    ],
    [
      "list",
      "item",
      "1",
    ],
    [
      "list",
      "item",
      "2",
    ],
  ])

  > replace(local.local_tuple.0, "list", "tuple")
  "tuple_item_0"

  > split("_", local.local_tuple.0)
  tolist([
    "list",
    "item",
    "0",
  ])

  > startswith(local.local_string_multiline, "First")
  true

  > startswith(local.local_string_multiline, "Second")
  false

  > strcontains(local.local_string_multiline, "First")
  true

  > strcontains(local.local_string_multiline, "Third")
  false

  > strrev(local.local_string)
  "gnirts"

  > substr(local.local_string_multiline, 6, 4)
  "Line"

  > substr(local.local_string_multiline, -12, 6)
  "Second"

  > title(join(" ", split("_", local.local_tuple.0)))
  "List Item 0"

  > trim(local.local_string_multiline, "\n ")
  <<EOT
  First Line
  Second Line
  EOT

  > trimprefix(local.local_string_multiline, "First")
  <<EOT
  Line
  Second Line

  EOT

  EOT
  > trimsuffix(local.local_string_multiline, "Line\n")
  <<EOT
  First Line
  Second 
  EOT

  > trimspace(local.local_string_multiline)
  <<EOT
  First Line
  Second Line
  EOT

  */

  local_ds_list_of_conditions                   = [true, false, true, false, true]
  local_ds_list_of_conditions_alltrue           = [true, true, true]
  local_ds_list_of_conditions_allfalse          = [false, false, false]
  local_ds_list_of_conditions_null_prefix       = [null, null, "string"]
  local_ds_list_of_conditions_null_prefix_lists = [[], [null, null, "string"]]
  local_ds_list_strings                         = ["string1", "string2", "string3"]
  local_ds_list_strings_dublicates              = ["string1", "string2", "string3", "string1", "string2", "string3"]
  local_ds_list_strings_dublicates_mask         = ["good", "neutral", "bad", "bad", "good", "bad"]
  local_ds_list_strings_dublicates_intersection = ["string1", "string2"]
  local_ds_list_strings_dublicates_out          = ["string4", "string5"]
  local_ds_list_strings_of_lists                = [["string1", "string2", ["string1", "string2"]], ["string3", "string4"]]
  local_ds_map_strings                          = { key1 = "string1", key2 = "string2", key3 = "string3" }
  local_ds_map_strings_merge                    = { key4 = "string4" }
  local_ds_map_strings_merge_complex            = { key1 = { key1_1 = "string1_1" } }
  local_ds_map_strings_merge_complex_sub        = { key1 = { key1_2 = "string1_2" } }
  local_ds_one_element_list                     = ["string"]
  local_ds_empty_list                           = []
  local_ds_fruits_map                           = { "warehouse1" = ["apple", "pomegranate"], "warehouse2" = ["orange", "apple"], "warehouse3" = ["banana", "apple"] }

  local_collection_functions = {
    alltrue                  = alltrue(local.local_ds_list_of_conditions)
    alltrue_alltrue          = alltrue(local.local_ds_list_of_conditions_alltrue)
    anytrue                  = anytrue(local.local_ds_list_of_conditions)
    anytrue_allfalse         = anytrue(local.local_ds_list_of_conditions_allfalse)
    chunklist                = chunklist(local.local_ds_numbers_list, 2)
    coalesce                 = coalesce(local.local_ds_list_of_conditions_null_prefix...)
    coalesce_list            = coalescelist(local.local_ds_list_of_conditions_null_prefix_lists...)
    compact                  = compact(local.local_ds_list_of_conditions_null_prefix)
    concat                   = concat(local.local_ds_list_of_conditions_null_prefix, local.local_ds_list_of_conditions_allfalse)
    contains                 = contains(local.local_ds_list_strings_dublicates, "string1")
    contains_false           = contains(local.local_ds_list_strings_dublicates, "string4")
    distinct                 = distinct(local.local_ds_list_of_conditions)
    distinct_strings         = distinct(local.local_ds_list_strings_dublicates)
    element_0                = element(local.local_ds_list_strings, 0)
    element_3                = element(local.local_ds_list_strings, 3)
    element_1                = element(local.local_ds_list_strings, 1)
    element_4                = element(local.local_ds_list_strings, 4)
    flatten                  = flatten(local.local_ds_list_strings_of_lists)
    index                    = index(local.local_ds_list_strings, "string2")
    keys                     = keys(local.local_ds_map_strings)
    values                   = values(local.local_ds_map_strings)
    length                   = length(local.local_ds_list_strings)
    length_map               = length(local.local_ds_map_strings)
    tolist                   = tolist(local.local_ds_list_strings)
    lookup                   = lookup(local.local_ds_map_strings, "key1", "not found")
    lookup_not_found         = lookup(local.local_ds_map_strings, "key4", "not found")
    tomap                    = tomap(local.local_ds_map_strings)
    matchkeys                = matchkeys(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_mask, ["good", "neutral"])
    merge                    = merge(local.local_ds_map_strings, local.local_ds_map_strings_merge)
    merge_complex            = merge(local.local_ds_map_strings, local.local_ds_map_strings_merge_complex)
    merge_complex_sub        = merge(local.local_ds_map_strings_merge_complex, local.local_ds_map_strings_merge_complex_sub)
    one                      = one(local.local_ds_one_element_list)
    one_empty                = one(local.local_ds_empty_list)
    range_3                  = range(3)
    range_1_3                = range(1, 3)
    range_1_3_step           = range(1, 3, 0.5)
    reverse                  = reverse(local.local_ds_list_strings)
    setintersection          = setintersection(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_intersection)
    setintersection_out      = setintersection(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_out)
    setproduct               = setproduct(local.local_ds_list_strings, local.local_ds_list_strings_dublicates_out)
    setsubtract              = setsubtract(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_out)
    setsubtract_intersection = setsubtract(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_intersection)
    setunion                 = setunion(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_out)
    slice                    = slice(local.local_ds_list_strings_dublicates, 1, 4)
    sort                     = sort(local.local_ds_list_strings_dublicates)
    sum                      = sum(local.local_ds_numbers_list)
    transpose                = transpose(local.local_ds_fruits_map)
    zipmap                   = zipmap(keys(local.local_ds_map_strings), values(local.local_ds_map_strings))
  }
  /*
  ** Collection Functions

  > alltrue(local.local_ds_list_of_conditions)
  false

  > alltrue(local.local_ds_list_of_conditions_alltrue)
  true

  > anytrue(local.local_ds_list_of_conditions)
  true

  > anytrue(local.local_ds_list_of_conditions_allfalse)
  false

  > chunklist(local.local_ds_numbers_list, 2)
  tolist([
    tolist([
      1,
      2,
    ]),
    tolist([
      3,
      4,
    ]),
    tolist([
      5,
    ]),
  ])

  > coalesce(local.local_ds_list_of_conditions_null_prefix...)
  "string"

  > coalescelist(local.local_ds_list_of_conditions_null_prefix_lists...)
  [
    null,
    null,
    "string",
  ]

  > local.local_ds_list_of_conditions_null_prefix
  [
    null,
    null,
    "string",
  ]
  > compact(local.local_ds_list_of_conditions_null_prefix)
  tolist([
    "string",
  ])

  > concat(local.local_ds_list_of_conditions_null_prefix, local.local_ds_list_of_conditions_allfalse)
  [
    null,
    null,
    "string",
    false,
    false,
    false,
  ]

  > contains(local.local_ds_list_strings_dublicates, "string1")
  true

  > contains(local.local_ds_list_strings_dublicates, "string4")
  false

  > distinct(local.local_ds_list_of_conditions)
  tolist([
    true,
    false,
  ])

  > distinct(local.local_ds_list_strings_dublicates)
  tolist([
    "string1",
    "string2",
    "string3",
  ])

  > element(local.local_ds_list_strings, 0)
  "string1"

  > element(local.local_ds_list_strings, 3)
  "string1"

  > element(local.local_ds_list_strings, 1)
  "string2"

  > element(local.local_ds_list_strings, 4)
  "string2"

  > flatten(local.local_ds_list_strings_of_lists)
  [
    "string1",
    "string2",
    "string1",
    "string2",
    "string3",
    "string4",
  ]

  > index(local.local_ds_list_strings, "string2")
  1

  > keys(local.local_ds_map_strings)
  [
    "key1",
    "key2",
    "key3",
  ]

  > values(local.local_ds_map_strings)
  [
    "string1",
    "string2",
    "string3",
  ]

  > length(local.local_ds_list_strings)
  3

  > length(local.local_ds_map_strings)
  3

  > tolist(local.local_ds_list_strings)
  tolist([
    "string1",
    "string2",
    "string3",
  ])

  > lookup(local.local_ds_map_strings, "key1", "not found")
  "string1"

  > lookup(local.local_ds_map_strings, "key4", "not found")
  "not found"

  > tomap(local.local_ds_map_strings)
  tomap({
    "key1" = "string1"
    "key2" = "string2"
    "key3" = "string3"
  })

  > matchkeys(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_mask, ["good", "neutral"])
  tolist([
    "string1",
    "string2",
    "string2",
  ])

  > merge(local.local_ds_map_strings, local.local_ds_map_strings_merge)
  {
    "key1" = "string1"
    "key2" = "string2"
    "key3" = "string3"
    "key4" = "string4"
  }

  > merge(local.local_ds_map_strings, local.local_ds_map_strings_merge_complex)
  {
    "key1" = {
      "key1_1" = "string1_1"
    }
    "key2" = "string2"
    "key3" = "string3"
  }

  > merge(local.local_ds_map_strings, local.local_ds_map_strings_merge_complex, local.local_ds_map_strings_merge_complex_sub)
  {
    "key1" = {
      "key1_2" = "string1_2"
    }
    "key2" = "string2"
    "key3" = "string3"
  }

  > one(local.local_ds_one_element_list)
  "string"

  > one(local.local_ds_empty_list)
  null

  > one(local.local_ds_list_strings_dublicates[*])
  ╷
  │ Error: Invalid function argument
  │ 
  │ Invalid value for "list" parameter: must be a list, set, or tuple value with either zero or one elements.
  ╵

  > range(3)
  tolist([
    0,
    1,
    2,
  ])

  > range(0, 3)
  tolist([
    0,
    1,
    2,
  ])

  > range(0, 3, 0.5)
  tolist([
    0,
    0.5,
    1,
    1.5,
    2,
    2.5,
  ])

  > reverse(local.local_ds_list_strings)
  [
    "string3",
    "string2",
    "string1",
  ]

  > setintersection(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_intersection)
  toset([
    "string1",
    "string2",
  ])

  > setintersection(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_out)
  toset([])

  > setproduct(local.local_ds_list_strings, local.local_ds_list_strings_dublicates_out)
  tolist([
    [
      "string1",
      "string4",
    ],
    [
      "string1",
      "string5",
    ],
    [
      "string2",
      "string4",
    ],
    [
      "string2",
      "string5",
    ],
    [
      "string3",
      "string4",
    ],
    [
      "string3",
      "string5",
    ],
  ])

  > setsubtract(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_out)
  toset([
    "string1",
    "string2",
    "string3",
  ])

  > setsubtract(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_intersection)
  toset([
    "string3",
  ])

  > setunion(local.local_ds_list_strings_dublicates, local.local_ds_list_strings_dublicates_out)
  toset([
    "string1",
    "string2",
    "string3",
    "string4",
    "string5",
  ])

  > slice(local.local_ds_list_strings_dublicates, 1, 4)
  [
    "string2",
    "string3",
    "string1",
  ]

  > sort(local.local_ds_list_strings_dublicates)
  tolist([
    "string1",
    "string1",
    "string2",
    "string2",
    "string3",
    "string3",
  ])

  > sum(local.local_ds_numbers_list)
  15

  > transpose(local.local_ds_fruits_map)
  tomap({
    "apple" = tolist([
      "warehouse1",
      "warehouse2",
      "warehouse3",
    ])
    "banana" = tolist([
      "warehouse3",
    ])
    "orange" = tolist([
      "warehouse2",
    ])
    "pomegranate" = tolist([
      "warehouse1",
    ])
  })

  > zipmap(keys(local.local_ds_map_strings), values(local.local_ds_map_strings))
  {
    "key1" = "string1"
    "key2" = "string2"
    "key3" = "string3"
  }

  */

  local_ds_csv = <<-EOF
  "key1","key2","key3"
  "value1_1","value1_2","value1_3"
  "value2_1","value2_2","value2_3"
  EOF

  local_ds_json = <<-EOF
  [
    {
      "key1": "value1_1",
      "key2": "value1_2",
      "key3": "value1_3"
    },
    {
      "key1": "value2_1",
      "key2": "value2_2",
      "key3": "value2_3"
    }
  ]
  EOF

  local_ds_yaml = <<-EOF
    key1: 
      - value1_1
      - value2_1
    key2:
      - value1_2
      - value2_2
    key3:
      - value1_3
      - value2_3
  EOF

  local_ds_url = "https://example.org/page/section?param1=value1&param2=value with spaces 2#anchor to paragraph"

  local_encoding_functions = {
    base64encode     = base64encode(local.local_string)
    base64decode     = base64decode(base64encode(local.local_string))
    base64gzip       = base64gzip(join("_", local.local_tuple))
    csvdecode        = csvdecode(local.local_ds_csv)
    jsondecode       = jsondecode(local.local_ds_json)
    jsonencode       = jsonencode(local.local_ds_map_strings)
    textencodebase64 = textencodebase64(local.local_string, "UTF-8")
    textdecodebase64 = textdecodebase64(textencodebase64(local.local_string, "UTF-8"), "UTF-8")
    urlencode        = urlencode(local.local_ds_url)
    yamldecode       = yamldecode(local.local_ds_yaml)
    yamlencode       = yamlencode(jsondecode(local.local_ds_json))
  }
  /*
  ** Encoding Functions

  > base64encode(local.local_string)
  "c3RyaW5n"

  > base64decode(base64encode(local.local_string))
  "string"

  > base64gzip(join("_", local.local_tuple))
  "H4sIAAAAAAAA/8rJLC6JzyxJzY03iEewDZHYRgAAAAD//wEAAP//5KYCzyMAAAA="

  > csvdecode(local.local_ds_csv)
  tolist([
    {
      "key1" = "value1_1"
      "key2" = "value1_2"
      "key3" = "value1_3"
    },
    {
      "key1" = "value2_1"
      "key2" = "value2_2"
      "key3" = "value2_3"
    },
  ])

  > jsondecode(local.local_ds_json)
  [
    {
      "key1" = "value1_1"
      "key2" = "value1_2"
      "key3" = "value1_3"
    },
    {
      "key1" = "value2_1"
      "key2" = "value2_2"
      "key3" = "value2_3"
    },
  ]

  > jsonencode(local.local_ds_map_strings)
  "{\"key1\":\"string1\",\"key2\":\"string2\",\"key3\":\"string3\"}"


  > textencodebase64(local.local_string, "UTF-8")
  "c3RyaW5n"

  > textdecodebase64(textencodebase64(local.local_string, "UTF-8"), "UTF-8")
  "string"

  > urlencode(local.local_ds_url)
  "https%3A%2F%2Fexample.org%2Fpage%2Fsection%3Fparam1%3Dvalue1%26param2%3Dvalue+with+spaces+2%23anchor+to+paragraph"

  > yamldecode(local.local_ds_yaml)
  {
    "key1" = [
      "value1_1",
      "value2_1",
    ]
    "key2" = [
      "value1_2",
      "value2_2",
    ]
    "key3" = [
      "value1_3",
      "value2_3",
    ]
  }

  > yamlencode(jsondecode(local.local_ds_json))
  <<EOT
  - "key1": "value1_1"
    "key2": "value1_2"
    "key3": "value1_3"
  - "key1": "value2_1"
    "key2": "value2_2"
    "key3": "value2_3"

  EOT
  */


  local_ds_path               = "/path/to/file.txt"
  local_ds_relative_path      = "./terraform101.tf"
  local_ds_relative_path_home = "~/terraform101.tf"
  local_ds_datafile           = "./terraform101_data.txt"
  local_ds_templatefile       = "./terraform101_template.tftpl"

  filesystem_functions = {
    abspath       = abspath(local.local_ds_relative_path)
    dirname       = dirname(local.local_ds_relative_path)
    dirname_path  = dirname(local.local_ds_path)
    pathexpand    = pathexpand(local.local_ds_relative_path_home)
    basename      = basename(local.local_ds_path)
    basename_home = basename(local.local_ds_relative_path_home)
    file          = file(local.local_ds_datafile)
    fileexists    = fileexists(local.local_ds_datafile)
    fileset       = fileset("./", "*.txt")
    filebase64    = filebase64(local.local_ds_datafile)
    templatefile  = templatefile(local.local_ds_templatefile, { map = local.local_ds_map_strings })
  }

  /*
  ** Filesystem Functions

  > abspath(local.local_ds_relative_path)
  "/root/terraform101/terraform101.tf"

  > dirname(local.local_ds_relative_path)
  "."

  > dirname(local.local_ds_path)
  "/path/to"

  > pathexpand(local.local_ds_relative_path_home)
  "/root/terraform101.tf"

  > basename(local.local_ds_path)
  "file.txt"

  > basename(local.local_ds_relative_path_home)
  "terraform101.tf"

  > file(local.local_ds_datafile)
  <<EOT
  First Line
  Second Line
  Third Line

  EOT

  > fileexists(local.local_ds_datafile)
  true

  > fileset("./", "*.txt")
  toset([
    "terraform101_data.txt",
  ])

  > filebase64(local.local_ds_datafile)
  "Rmlyc3QgTGluZQpTZWNvbmQgTGluZQpUaGlyZCBMaW5lCg=="

  > templatefile(local.local_ds_templatefile, { map = local.local_ds_map_strings })
  <<EOT
  set key1 = string1
  set key2 = string2
  set key3 = string3

  EOT

  */

  local_ds_datetime = "2023-09-01T23:12:01Z"

  datetime_functions = {
    formatdate      = formatdate("DD MMM YYYY hh:mm ZZZ", local.local_ds_datetime)
    timeadd         = timeadd(local.local_ds_datetime, "20h")
    timecmp_later   = timecmp(local.local_ds_datetime, timeadd(local.local_ds_datetime, "20h"))
    timecmp_earlier = timecmp(local.local_ds_datetime, timeadd(local.local_ds_datetime, "-20h"))
    timecmp_same    = timecmp(local.local_ds_datetime, timeadd(local.local_ds_datetime, "0h"))
    timestamp       = timestamp()
  }
  /*
  ** Date and Time Functions

  > formatdate("DD MMM YYYY hh:mm ZZZ", local.local_ds_datetime)
  "01 Sep 2023 23:12 UTC"

  > timeadd(local.local_ds_datetime, "20h")
  "2023-09-02T19:12:01Z"

  > timeadd(local.local_ds_datetime, "-20h")
  "2023-09-01T03:12:01Z"

  > timecmp(local.local_ds_datetime, timeadd(local.local_ds_datetime, "20h"))
  -1

  > timecmp(local.local_ds_datetime, timeadd(local.local_ds_datetime, "-20h"))
  1

  > timecmp(local.local_ds_datetime, timeadd(local.local_ds_datetime, "0h"))
  0

  > timestamp()
  "2023-09-17T08:35:49Z"

  > plantimestamp() will return a consistent timestamp representing the date and time during the plan.
  The plantimestamp() function is not available within the Terraform console.

  */

  local_ds_domain_name        = "www.example.org"
  local_ds_datafile_encrypted = "./terraform101_data_encrypted.txt"
  local_ds_private_key        = "./terraform101_example_private_key.pem"

  hashandcrypto_functions = {
    base64sha256     = base64sha256(local.local_string)
    base64sha512     = base64sha512(local.local_string)
    bcrypt           = bcrypt(local.local_string)
    filebase64sha256 = filebase64sha256(local.local_ds_datafile)
    filebase64sha512 = filebase64sha512(local.local_ds_datafile)
    filemd5          = filemd5(local.local_ds_datafile)
    filesha1         = filesha1(local.local_ds_datafile)
    filesha256       = filesha256(local.local_ds_datafile)
    filesha512       = filesha512(local.local_ds_datafile)
    md5              = md5(local.local_string)
    sha1             = sha1(local.local_string)
    sha256           = sha256(local.local_string)
    sha512           = sha512(local.local_string)
    uuid             = uuid()
    uuidv5           = uuidv5("dns", local.local_ds_domain_name)
    rsadecrypt       = rsadecrypt(filebase64(local.local_ds_datafile_encrypted), file(local.local_ds_private_key))
  }
  /*
  ** Hash and Crypto Functions 

  > base64sha256(local.local_string)
  "RzKH+CmNunFjqJeQiVj3wOrnM+JdLgJ5kuou3JvtL6g="

  > base64sha512(local.local_string)
  "J1fLPK/DmvRRq7Jpe+ebSrYdY9dNhbBBhinejCaBG1KfPzeA0BUAY/9Vor7udMTsECoqJzGh8ffxDUc60Ypqhw=="

  > bcrypt(local.local_string)
  "$2a$10$XuMed8tGyUuxe5vkzj9CAOLY4Ueg9.Yb2hxd3D5VyWvO.3.Q3kT5S"

  > filebase64sha256(local.local_ds_datafile)
  "E4+hYIOLf1u4bcBH9tLiFSdytPs7tlCudsc1S4qg8uc="

  > filebase64sha512(local.local_ds_datafile)
  "mUzmidU8pCXmWIYOlXr65ZB4703827I1uHk6LTMtOhgznhhITHoDtXaO+UdVGWE4Hoa6ZMMciIOMJvBsk6o09g=="

  > filemd5(local.local_ds_datafile)
  "8b061168ef6147d6078139194633c172"

  > filesha1(local.local_ds_datafile)
  "febb76797e5e285fdaf228482f7b77d689f2d115"

  > filesha256(local.local_ds_datafile)
  "138fa160838b7f5bb86dc047f6d2e2152772b4fb3bb650ae76c7354b8aa0f2e7"

  > filesha512(local.local_ds_datafile)
  "994ce689d53ca425e658860e957afae59078ef4dfcdbb235b8793a2d332d3a18339e18484c7a03b5768ef947551961381e86ba64c31c88838c26f06c93aa34f6"

  > md5(local.local_string)
  "b45cffe084dd3d20d928bee85e7b0f21"

  > sha1(local.local_string)
  "ecb252044b5ea0f679ee78ec1a12904739e2904d"

  > sha256(local.local_string)
  "473287f8298dba7163a897908958f7c0eae733e25d2e027992ea2edc9bed2fa8"

  > uuid()
  "225e3462-f9e5-ea73-52e8-118d4c73d99a"

  > uuidv5("dns", local.local_ds_domain_name)
  "74738ff5-5367-5958-9aee-98fffdcd1876"

  openssl genrsa -out terraform101_example_private_key.pem 1024
  openssl rsa -in ./terraform101_example_private_key.pem -pubout > ./terraform101_example_public_key.pem
  openssl rsautl -encrypt -inkey ./terraform101_example_public_key.pem -pubin -in ./terraform101_data.txt -out ./terraform101_data_encrypted.txt

  > rsadecrypt(filebase64(local.local_ds_datafile_encrypted), file(local.local_ds_private_key))
  <<EOT
  First Line
  Second Line
  Third Line

  EOT

  */

  local_ds_ip_network = "10.1.0.0/16"

  /*
  ** IP Network Functions

  > cidrsubnet(local.local_ds_ip_network, 2, 1)
  "10.1.64.0/18"

  > cidrsubnet(local.local_ds_ip_network, 2, 2)
  "10.1.128.0/18"

  > cidrsubnet(cidrsubnet(local.local_ds_ip_network, 2, 2), 6, 1)
  "10.1.129.0/24"

  > cidrsubnet(cidrsubnet(local.local_ds_ip_network, 2, 2), 6, 2)
  "10.1.130.0/24"

  > cidrsubnets(local.local_ds_ip_network, 4, 4, 4, 8, 8, 8)
  tolist([
    "10.1.0.0/20",
    "10.1.16.0/20",
    "10.1.32.0/20",
    "10.1.48.0/24",
    "10.1.49.0/24",
    "10.1.50.0/24",
  ])

  > cidrnetmask(local.local_ds_ip_network)
  "255.255.0.0"

  > cidrhost(cidrsubnet(local.local_ds_ip_network, 2, 2), 300)
  "10.1.129.44"

  */

  typeconvertion_functions = {
    can_true     = can(local.local_ds_map_strings.key2)
    can_false    = can(local.local_ds_map_strings.key4)
    try_true     = try(local.local_ds_map_strings.key2, "key 2 not found")
    try_false    = try(local.local_ds_map_strings.key4, "key 4 not found")
    sensitive    = sensitive(local.local_string)
    nonsensitive = nonsensitive(sensitive(local.local_string))
    tobool       = tobool("true")
    tolist       = tolist(local.local_set)
    tomap        = tomap(local.local_object)
    tonumber     = tonumber(local.local_ds_number_in_string)
    toset        = toset(local.local_tuple)
    tostring     = tostring(local.local_ds_number_float)
  }

  /*
  ** Type Conversion Functions

  > can(local.local_ds_map_strings.key2)
  true

  > can(local.local_ds_map_strings.key4)
  false

  > try(local.local_ds_map_strings.key2, "key 2 not found")
  "string2"

  > try(local.local_ds_map_strings.key4, "key 4 not found")
  "key 4 not found"

  > sensitive(local.local_string)
  (sensitive value)

  > nonsensitive(sensitive(local.local_string))
  "string"

  > tobool("true")
  true

  > tolist(local.local_set)
  tolist([
    "set_dublicate_value_1",
    "set_dublicate_value_2",
    "set_unique_value_1",
    "set_unique_value_2",
  ])

  > tomap(local.local_object)
  tomap({
    "key1" = "value1"
    "key2" = "value2"
  })

  > tonumber(local.local_ds_number_in_string)
  1

  > toset(local.local_tuple)
  toset([
    "list_item_0",
    "list_item_1",
    "list_item_2",
  ])

  > tostring(local.local_ds_number_float)
  "2.5"

  type() returns the type of a given value.
  This is a special function which is only available in the terraform console command.

  > type(local.local_null)
  dynamic

  > type(local.local_bool)
  bool

  > type(local.local_number)
  number

  > type(local.local_number_float)
  number

  > type(local.local_string)
  string

  > type(local.local_tuple)
  tuple([
      string,
      string,
      string,
  ])

  > type(local.local_list)
  list(string)

  > type(local.local_object)
  object({
      key1: string,
      key2: string,
  })

  > type(local.local_map)
  map(string)

  > type(local.local_set)
  set(string)

  */

}


/*
** Resources
*/

/*
** Resources from LIST/TUPLE
*/

locals {
  local_files_content_list = [
    "File 0 Content",
    "File 1 Content",
    "File 2 Content",
  ]
}

resource "null_resource" "terraform101_count__list" {
  count = length(local.local_files_content_list)

  triggers = {
    file_name = "file${count.index}.txt"
    content   = local.local_files_content_list[count.index]
  }
}
/*
terraform plan -target=null_resource.terraform101_count__list

# null_resource.terraform101_count__list[0] will be created
+ resource "null_resource" "terraform101_count__list" {
    + triggers = {
        + "content"   = "File 0 Content"
        + "file_name" = "file0.txt"
      }
  }

# null_resource.terraform101_count__list[1] will be created
+ resource "null_resource" "terraform101_count__list" {
    + triggers = {
        + "content"   = "File 1 Content"
        + "file_name" = "file1.txt"
      }
  }

# null_resource.terraform101_count__list[2] will be created
+ resource "null_resource" "terraform101_count__list" {
    + triggers = {
        + "content"   = "File 2 Content"
        + "file_name" = "file2.txt"
      }
  }
*/

resource "null_resource" "terraform101_for_each__list" {
  for_each = toset(local.local_files_content_list)

  triggers = {
    file_name = "file${each.key}.txt"
    content   = each.value
  }
}
/*
terraform plan -target=null_resource.terraform101_for_each__list

# null_resource.terraform101_for_each__list["File 0 Content"] will be created
+ resource "null_resource" "terraform101_for_each__list" {
    + triggers = {
        + "content"   = "File 0 Content"
        + "file_name" = "fileFile 0 Content.txt"
      }
  }

# null_resource.terraform101_for_each__list["File 1 Content"] will be created
+ resource "null_resource" "terraform101_for_each__list" {
    + triggers = {
        + "content"   = "File 1 Content"
        + "file_name" = "fileFile 1 Content.txt"
      }
  }

# null_resource.terraform101_for_each__list["File 2 Content"] will be created
+ resource "null_resource" "terraform101_for_each__list" {
    + triggers = {
        + "content"   = "File 2 Content"
        + "file_name" = "fileFile 2 Content.txt"
      }
  }
*/

resource "null_resource" "terraform101_for_each__list_to_map" {
  for_each = {
    for i, item in local.local_files_content_list :
    "file${i}.txt" => {
      content = item
    }
  }

  triggers = {
    file_name = each.key
    content   = each.value.content
  }
}
/*
terraform plan -target=null_resource.terraform101_for_each__list_to_map

# null_resource.terraform101_for_each__list_to_map["file0.txt"] will be created
+ resource "null_resource" "terraform101_for_each__list_to_map" {
    + triggers = {
        + "content"   = "File 0 Content"
        + "file_name" = "file0.txt"
      }
  }

# null_resource.terraform101_for_each__list_to_map["file1.txt"] will be created
+ resource "null_resource" "terraform101_for_each__list_to_map" {
    + triggers = {
        + "content"   = "File 1 Content"
        + "file_name" = "file1.txt"
      }
  }

# null_resource.terraform101_for_each__list_to_map["file2.txt"] will be created
+ resource "null_resource" "terraform101_for_each__list_to_map" {
    + triggers = {
        + "content"   = "File 2 Content"
        + "file_name" = "file2.txt"
      }
  }
*/

/*
** Resources from MAP/OBJECT
*/

locals {
  local_folders_map = {
    "folder0" = {
      "path" = "/tmp/folder0"
    }
    "folder1" = {
      "path" = "/tmp/map/folder1"
    }
  }

  local_files_content_map = {
    "file0.txt" = {
      content = "File 0 Content"
      folder  = "folder0"
    }
    "file1.txt" = {
      content = "File 1 Content"
      folder  = "folder0"
    }
    "file2.txt" = {
      content = "File 2 Content"
      folder  = "folder1"
    }
  }
}

resource "null_resource" "terraform101_for_each__map" {
  for_each = local.local_files_content_map

  triggers = {
    file_name   = each.key
    content     = each.value.content
    folder_path = local.local_folders_map[each.value.folder].path
  }
}
/*
terraform plan -target=null_resource.terraform101_for_each__map

# null_resource.terraform101_for_each__map["file0.txt"] will be created
+ resource "null_resource" "terraform101_for_each__map" {
    + triggers = {
        + "content"     = "File 0 Content"
        + "file_name"   = "file0.txt"
        + "folder_path" = "/tmp/folder0"
      }
  }

# null_resource.terraform101_for_each__map["file1.txt"] will be created
+ resource "null_resource" "terraform101_for_each__map" {
    + triggers = {
        + "content"     = "File 1 Content"
        + "file_name"   = "file1.txt"
        + "folder_path" = "/tmp/folder0"
      }
  }

# null_resource.terraform101_for_each__map["file2.txt"] will be created
+ resource "null_resource" "terraform101_for_each__map" {
    + triggers = {
        + "content"     = "File 2 Content"
        + "file_name"   = "file2.txt"
        + "folder_path" = "/tmp/map/folder1"
      }
  }
*/

resource "null_resource" "terraform101_for_each__map_filtered" {
  for_each = { for k, v in local.local_files_content_map : k => v if v.folder == "folder0" }

  triggers = {
    file_name   = each.key
    content     = each.value.content
    folder_path = local.local_folders_map[each.value.folder].path
  }
}
/*
terraform plan -target=null_resource.terraform101_for_each__map_filtered

# null_resource.terraform101_for_each__map_filtered["file0.txt"] will be created
+ resource "null_resource" "terraform101_for_each__map_filtered" {
    + triggers = {
        + "content"     = "File 0 Content"
        + "file_name"   = "file0.txt"
        + "folder_path" = "/tmp/folder0"
      }
  }

# null_resource.terraform101_for_each__map_filtered["file1.txt"] will be created
+ resource "null_resource" "terraform101_for_each__map_filtered" {
    + triggers = {
        + "content"     = "File 1 Content"
        + "file_name"   = "file1.txt"
        + "folder_path" = "/tmp/folder0"
      }
  }
*/

resource "null_resource" "terraform101_for_each__map_custom" {
  for_each = { for k, v in local.local_files_content_map :
    k => {
      content     = v.content
      folder_path = local.local_folders_map[v.folder].path
    }
  }

  triggers = {
    file_name   = each.key
    content     = each.value.content
    folder_path = each.value.folder_path
  }
}

/*
terraform plan -target=null_resource.terraform101_for_each__map_custom

# null_resource.terraform101_for_each__map_custom["file0.txt"] will be created
+ resource "null_resource" "terraform101_for_each__map_custom" {
    + triggers = {
        + "content"     = "File 0 Content"
        + "file_name"   = "file0.txt"
        + "folder_path" = "/tmp/folder0"
      }
  }

# null_resource.terraform101_for_each__map_custom["file1.txt"] will be created
+ resource "null_resource" "terraform101_for_each__map_custom" {
    + triggers = {
        + "content"     = "File 1 Content"
        + "file_name"   = "file1.txt"
        + "folder_path" = "/tmp/folder0"
      }
  }

# null_resource.terraform101_for_each__map_custom["file2.txt"] will be created
+ resource "null_resource" "terraform101_for_each__map_custom" {
    + triggers = {
        + "content"     = "File 2 Content"
        + "file_name"   = "file2.txt"
        + "folder_path" = "/tmp/map/folder1"
      }
  }
*/
