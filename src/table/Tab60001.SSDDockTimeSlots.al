// table 60001 "SSD Dock Time Slots"
// {
//     Caption = 'Dock Time Slots';
//     DataClassification = CustomerContent;
//     DrillDownPageId = "SSD Dock Time Slots";
//     LookupPageId = "SSD Dock Time Slots";

//     fields
//     {
//         field(1; "Location Code"; Code[10])
//         {
//             Caption = 'Location Code';
//             TableRelation = Location;
//         }
//         field(5; "Dock No."; Code[20])
//         {
//             Caption = 'Dock No.';
//             TableRelation = "SSD Dock".Code where("Location Code" = field("Location Code"));
//         }
//         field(10; "Slot No."; Code[20])
//         {
//             Caption = 'Slot No.';
//         }
//         field(20; "Starting Time"; Time)
//         {
//             Caption = 'Starting Time';

//             trigger OnValidate()
//             begin
//                 if ("Ending Time" = 0T) or ("Ending Time" < "Starting Time") then begin
//                     ShopCalendar.SetRange("Dock No.", "Dock No.");
//                     ShopCalendar.SetRange("Starting Time", "Starting Time", 235959T);
//                     if ShopCalendar.FindFirst() then
//                         "Ending Time" := ShopCalendar."Starting Time"
//                     else
//                         "Ending Time" := 235959T;
//                 end;
//                 CheckRedundancy();
//             end;
//         }
//         field(21; "Ending Time"; Time)
//         {
//             Caption = 'Ending Time';

//             trigger OnValidate()
//             begin
//                 if ("Ending Time" < "Starting Time") and ("Ending Time" <> 000000T) then Error(HigherTxt, FieldCaption("Ending Time"), FieldCaption("Starting Time"));
//                 CheckRedundancy();
//             end;
//         }
//         field(30; "Planned Receipts"; Integer)
//         {
//             Caption = 'Planned Receipts';
//             Editable = false;
//             FieldClass = FlowField;
//             CalcFormula = count("Warehouse Receipt Header" where("SSD Status" = const("SSD Receipt Status"::Planned), "Location Code" = field("Location Code")));//, "SSD Dock No."=field("Dock No."), "SSD Slot No."=field("Slot No.")));
//         }
//         field(40; "Planned Shipments"; Integer)
//         {
//             Caption = 'Planned Shipments';
//             Editable = false;
//             FieldClass = FlowField;
//             CalcFormula = count("Warehouse Shipment Header" where(Status = const(Released), "Location Code" = field("Location Code")));//, "SSD Dock No."=field("Dock No."), "SSD Slot No."=field("Slot No.")));
//         }
//         field(50; Blocked; Boolean)
//         {
//             Caption = 'Blocked';
//         }
//     }
//     keys
//     {
//         key(PK; "Location Code", "Dock No.", "Slot No.")
//         {
//             Clustered = true;
//         }
//     }
//     fieldgroups
//     {
//         fieldgroup(DropDown; "Slot No.", "Location Code", "Dock No.", "Planned Receipts", "Planned Shipments")
//         {
//         }
//     }
//     trigger OnInsert()
//     begin
//         TestField("Location Code");
//         TestField("Dock No.");
//         TestField("Slot No.");
//         TestField("Starting Time");
//         TestField("Ending Time");
//     end;

//     local procedure CheckRedundancy()
//     var
//         ShopCalendar2: Record "SSD Dock Time Slots";
//         TempShopCalendar: Record "SSD Dock Time Slots" temporary;
//     begin
//         ShopCalendar2.SetRange("Dock No.", "Dock No.");
//         if ShopCalendar2.Find('-') then
//             repeat
//                 TempShopCalendar := ShopCalendar2;
//                 TempShopCalendar.Insert();
//             until ShopCalendar2.Next() = 0;
//         TempShopCalendar := xRec;
//         if TempShopCalendar.Delete() then;
//         TempShopCalendar.SetRange("Dock No.", "Dock No.");
//         TempShopCalendar.SetRange("Starting Time", 0T, "Ending Time" - 1);
//         TempShopCalendar.SetRange("Ending Time", "Starting Time" + 1, 235959T);
//         if TempShopCalendar.FindFirst() then begin
//             if (TempShopCalendar."Starting Time" = "Starting Time") and (TempShopCalendar."Ending Time" = "Ending Time") then exit;
//             Error(RedundancyTxt, "Starting Time", "Ending Time", TempShopCalendar."Starting Time", TempShopCalendar."Ending Time");
//         end;
//     end;

//     var
//         ShopCalendar: Record "SSD Dock Time Slots";
//         HigherTxt: Label '%1 must be higher than %2.', Comment = '%1 Starting Time , %2 Ending Time';
//         RedundancyTxt: Label 'There is redundancy in the Time Slots. Actual Time Slot from : %1 to %2. Conflicting Time Slot from : %3 to %4.', Comment = '%1 Starting Time %2 Ending Time %3 Starting Time %4 Ending Time';
// }
