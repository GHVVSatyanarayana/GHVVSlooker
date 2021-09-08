view: order_items {
  sql_table_name: demo_db.order_items ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [id, orders.id, inventory_items.id]
    link: {
      label: "See as custom viz (heatmap)"
      url: "
      {% assign vis_config = '{
      \"minColor\" : \"#d6d6d6\",
      \"maxColor\" : \"#9a33e3\",
      \"dataLabels\" : false,
      \"custom_color_enabled\" : false,
      \"custom_color\" : \"forestgreen\",
      \"show_single_value_title\": true,
      \"show_comparison\" : false,
      \"comparison_type\" : \"value\",
      \"comparison_reverse_colors\": false,
      \"show_comparison_label\" : true,
      \"show_view_names\" : true,
      \"show_row_numbers\" : true,
      \"truncate_column_names\" : false,
      \"hide_totals\" : false,
      \"hide_row_totals\" : false,
      \"table_theme\" : \"editable\",
      \"limit_displayed_rows\" : false,
      \"enable_conditional_formatting\": false,
      \"conditional_formatting_include_totals\": false,
      \"conditional_formatting_include_nulls\": false,
      \"type\" : \"highcharts_heatmap\",
      \"stacking\" : \"\",
      \"show_value_labels\" : false,
      \"label_density\" : 25,
      \"legend_position\" : \"center\",
      \"x_axis_gridlines\" : false,
      \"y_axis_gridlines\" : true,
      \"y_axis_combined\" : true,
      \"show_y_axis_labels\" : true,
      \"show_y_axis_ticks\" : true,
      \"y_axis_tick_density\" : \"default\",
      \"y_axis_tick_density_custom\": 5,
      \"show_x_axis_label\" : true,
      \"show_x_axis_ticks\" : true,
      \"x_axis_scale\" : \"auto\",
      \"y_axis_scale_mode\" : \"linear\",
      \"ordering\" : \"none\",
      \"show_null_labels\" : false,
      \"show_totals_labels\" : false,
      \"show_silhouette\" : false,
      \"totals_color\" : \"#808080\",
      \"series_types\" : {},
      \"hidden_fields\" : [
      \"order_items.count\",
      \"order_items.total_sale_price\"
      ]
      }' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&sorts=products.category+asc,users.age_tier+asc&toggle=dat,pik,vis&limit=5000"
    }
  }
  }
