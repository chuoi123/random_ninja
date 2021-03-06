create or replace package consumer_data

as

  /** Data for generating random consumer data.
  * @author Morten Egan
  * @version 0.0.1
  * @project NINJA_RANDOM
  */
  npg_version             varchar2(250) := '1.3.0';

  nonfood_categories      varchar2(32000) := 'Kitchen,Clothes,Electronics,Cosmetics,Leisure,Jewelery,Furniture,Tools';
  food_categories         varchar2(32000) := 'Produce,Vegetables,Fruits,Meats,Canned goods,Dry goods,Dairy,Fish,Beverages,Frozen food';
  service_category        varchar2(32000) := 'Plumber,Carpenter,Builder,Consultant,Contractor';

  type consumer_item is record (
    item_name             varchar2(4000)
    , item_price_start    number
    , item_price_end      number
  );
  type consumer_item_list is table of consumer_item;
  type category_items_list is table of consumer_item_list index by varchar2(4000);
  items   category_items_list;

  type additive_group_rec is record (
    group_name            varchar2(50)
    , additives           varchar2(4000)
  );
  type additive_group_list is table of additive_group_rec;
  additives   additive_group_list;

end consumer_data;
/
