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
  > local.local_null
  null
  */

  local_bool = true
  /*
  > local.local_bool
  true

  > !local.local_bool
  false
  */

  local_number = 1
  /*
  > local.local_number
  1
  */

  local_number_float = 1.5
  /*
  > local.local_number_float
  1.5
  */

  local_string = "string"
  /*
  > local.local_string
  "string"
  */

  local_list_or_tuple = ["list_item_0", "list_item_1", "list_item_2"]
  /*
  > local.local_list_or_tuple
  [
    "list_item_0",
    "list_item_1",
    "list_item_2",
  ]

  > local.local_list_or_tuple[0]
  "list_item_0"

  > local.local_list_or_tuple.0
  "list_item_0"

  > local.local_list_or_tuple[3]
  ╷
  │ Error: Invalid index
  │ 
  │ The given key does not identify an element in this collection value: the given index is greater than or equal to the length of the collection.
  ╵
  */

  local_map_or_object = {
    key1 = "value1"
    key2 = "value2"
  }
  /*
  > local.local_map_or_object
  {
    "key1" = "value1"
    "key2" = "value2"
  }

  > local.local_map_or_object.key1
  "value1"

  > local.local_map_or_object["key1"]
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
    $${local.local_list_or_tuple[0]}: ${local.local_list_or_tuple[0]}
    $${local.local_list_or_tuple.0}: ${local.local_list_or_tuple.0} 
    $${local.local_map_or_object["key1"]}: ${local.local_map_or_object["key1"]}
    $${local.local_map_or_object.key1}: ${local.local_map_or_object.key1}

    Following iterpolations provokes an error:

    $${local.local_null}
    $${local.local_list_or_tuple}
    $${local.local_map_or_object}
    $${local.local_set}

    │ Error: Invalid template interpolation value
    │     │ local.local_null is null
    │     │ local.local_set is set of string with 3 elements
    │     │ local.local_map_or_object is object with 2 attributes
    │     │ local.local_list_or_tuple is tuple with 3 elements
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
      ${local.local_list_or_tuple[0]}: list_item_0
      ${local.local_list_or_tuple.0}: list_item_0 
      ${local.local_map_or_object["key1"]}: value1
      ${local.local_map_or_object.key1}: value1

      Following iterpolations provokes an error:

      ${local.local_null}
      ${local.local_list_or_tuple}
      ${local.local_map_or_object}
      ${local.local_set}

      │ Error: Invalid template interpolation value
      │     │ local.local_null is null
      │     │ local.local_set is set of string with 3 elements
      │     │ local.local_map_or_object is object with 2 attributes
      │     │ local.local_list_or_tuple is tuple with 3 elements
      │ 
      │ Cannot include the given value in a string template: string required.

  EOT
  */

  /**
  ** References to Named Values / Section
  ** Reference: https://developer.hashicorp.com/terraform/language/expressions/references
  */

  local_for_local_list_or_tuple = local.local_list_or_tuple[*]
  /*
  > local.local_for_local_list_or_tuple
  [
    "list_item_0",
    "list_item_1",
    "list_item_2",
  ]
  */

  local_for_item_in_local_list_or_tuple = local.local_list_or_tuple[0]
  /*
  > local.local_for_item_in_local_list_or_tuple
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
  local_list_or_tuple_for       = [for item in local.local_list_or_tuple : item]
  /*
  > local.local_list_or_tuple_for
  [
    "list_item_0",
    "list_item_1",
    "list_item_2",
  ]
  */

  local_list_or_tuple_for_index = [for i, item in local.local_list_or_tuple : "${i} - ${item}"]
  /*
  > local.local_list_or_tuple_for_index
  [
    "0 - list_item_0",
    "1 - list_item_1",
    "2 - list_item_2",
  ]
  */

  local_set_for_index           = [for i, item in local.local_set : "${i} - ${item}"]
  /*
  > local.local_set_for_index
  [
    "set_dublicate_value_1 - set_dublicate_value_1",
    "set_dublicate_value_2 - set_dublicate_value_2",
    "set_unique_value_1 - set_unique_value_1",
    "set_unique_value_2 - set_unique_value_2",
  ]
  */

  local_map_or_object_for       = [for key, value in local.local_map_or_object : "${key} - ${value}"]
  /*
  > local.local_map_or_object_for
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
  local_set_to_map_for_filtered          = { for key in local.local_set : key => "value for ${key}" if length(key) == 18 }
  /*
  > local.local_set_to_map_for_filtered
  {
    "set_unique_value_1" = "value for set_unique_value_1"
    "set_unique_value_2" = "value for set_unique_value_2"
  }
  */

  local_list_or_tuple_for_index_filtered = [for i, item in local.local_list_or_tuple : "${i} - ${item}" if i == 1]
  /*
  > local.local_list_or_tuple_for_index_filtered
  [
    "1 - list_item_1",
  ]
  */

  # grouping

  local_map_or_object_for_grouping = {
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

  local_map_or_object_for_grouped = {
    for key, value in local.local_map_or_object_for_grouping :
    value.group => key...
  }

  /*
  ** Built-in Functions
  ** Reference: https://developer.hashicorp.com/terraform/language/functions
  */

  local_numbers_list         = [1, 2, 3, 4, 5]
  local_number_in_string     = "1"
  local_number_in_string_hex = "FF"

  /*
  ** Numeric Functions

  > abs(local.local_op_number)
  2.5

  > abs(local.local_op_number_negative)
  2.5

  > ceil(local.local_op_number)
  3

  > floor(local.local_op_number)
  2

  > log(local.local_op_number, 2)
  1.3219280948873624

  > max(1, 2, 3, 4, 5)
  5

  > max(local.local_numbers_list...)
  5

  > min(local.local_numbers_list...)
  1

  > parseint(local.local_number_in_string, 10)
  1

  > parseint(local.local_number_in_string_hex, 16)
  255

  > pow(local.local_op_number, 2)
  6.25

  > signum(floor(local.local_op_number))
  1

  > signum(floor(local.local_op_number)-floor(local.local_op_number))
  0

  > signum(-floor(local.local_op_number))
  -1

  */

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

  > formatlist("prefix for %s", local.local_list_or_tuple)
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

  > join(";", local.local_list_or_tuple)
  "list_item_0;list_item_1;list_item_2"

  > lower(local.local_string_multiline)
  <<EOT
  first line
  second line

  EOT

  > regex("([a-z]+)_([a-z]+)_([0-9]+)", local.local_list_or_tuple.0)
  [
    "list",
    "item",
    "0",
  ]

  > regex("([a-z]+)_([a-z]+)_([0-9]+)", join(";",local.local_list_or_tuple))
  [
    "list",
    "item",
    "0",
  ]

  > regexall("([a-z]+)_([a-z]+)_([0-9]+)", join(";",local.local_list_or_tuple))
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

  > replace(local.local_list_or_tuple.0, "list", "tuple")
  "tuple_item_0"

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
  for_each = { for k,v in local.local_files_content_map : k => v if v.folder == "folder0" }

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
  for_each = {for k, v in local.local_files_content_map:
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
