// table 60009 "SSD Dock Planning"
// {
//     Caption = 'Dock Planning';
//     DataClassification = CustomerContent;

//     fields
//     {
//         field(1; "Location Code"; Code[10])
//         {
//             Caption = 'Location Code';
//             TableRelation = Location;
//         }
//         field(10; "Dock No."; Code[20])
//         {
//             Caption = 'Dock No.';
//             TableRelation = "SSD Dock" where("Location Code" = field("Location Code"));
//         }
//         field(20; "Time Slot No."; Code[20])
//         {
//             Caption = 'Time Slot No.';
//             TableRelation = "SSD Dock Time Slots"."Slot No." where("Location Code" = field("Location Code"), "Dock No." = field("Dock No."));
//         }
//         field(30; "Planning Date"; Date)
//         {
//             Caption = 'Planning Date';
//         }
//         field(31; "Item No."; Code[20])
//         {
//             Caption = 'Item No.';
//             TableRelation = Item;

//             trigger OnValidate()
//             var
//                 Item: Record Item;
//             begin
//                 if Item.Get("Item No.") then begin
//                     "Item Description" := Item.Description;
//                     "Base Unit of Measure" := Item."Base Unit of Measure";
//                 end
//                 else begin
//                     "Item Description" := '';
//                     Item."Base Unit of Measure" := '';
//                 end;
//             end;
//         }
//         field(50; Quantity; Decimal)
//         {
//             Caption = 'Quantity';
//         }
//         field(60; "Pallet Count"; Integer)
//         {
//             Caption = 'Pallet Count';
//         }
//         field(100; "Item Description"; Text[100])
//         {
//             Caption = 'Item Description';
//         }
//         field(110; "Base Unit of Measure"; Code[20])
//         {
//             Caption = 'Base Unit of Measure';
//         }
//         field(500; "Record Synced"; Boolean)
//         {
//             Caption = 'Record Synced';
//         }
//     }
//     keys
//     {
//         key(PK; "Location Code", "Dock No.", "Time Slot No.", "Planning Date", "Item No.")
//         {
//             Clustered = true;
//         }
//     }
//     trigger OnDelete()
//     var
//         SSDDockPlanningHistory: Record "SSD Dock Planning History";
//         RecordSyncMsg: Label 'Record is synced with WMS. Do you want to delete?';
//     begin
//         if Rec."Record Synced" then begin
//             if not Confirm(RecordSyncMsg, false) then exit;
//             SSDDockPlanningHistory.Init();
//             SSDDockPlanningHistory.TransferFields(Rec);
//             SSDDockPlanningHistory."Deleted By" := CopyStr(UserId, 1, 50);
//             SSDDockPlanningHistory.Insert();
//             RemoveShipmentLink(Rec);
//         end;
//     end;

//     procedure RemoveShipmentLink(SSDDockPlanning: Record "SSD Dock Planning")
//     var
//         WarehouseShipmentHeader: Record "Warehouse Shipment Header";
//         WarehouseShipmentLine: Record "Warehouse Shipment Line";
//     begin
//         WarehouseShipmentHeader.Reset();
//         WarehouseShipmentHeader.SetRange("Posting Date", SSDDockPlanning."Planning Date");
//         WarehouseShipmentHeader.SetRange("Location Code", SSDDockPlanning."Location Code");
//         // WarehouseShipmentHeader.SetRange("SSD Dock No.", SSDDockPlanning."Dock No.");
//         // WarehouseShipmentHeader.SetRange("SSD Slot No.", SSDDockPlanning."Time Slot No.");
//         if WarehouseShipmentHeader.FindSet() then
//             repeat
//                 WarehouseShipmentLine.SetRange("No.", WarehouseShipmentHeader."No.");
//                 WarehouseShipmentLine.SetRange("Item No.", SSDDockPlanning."Item No.");
//                 if WarehouseShipmentLine.FindSet() then
//                     repeat
//                         WarehouseShipmentLine."Pick Planned" := false;
//                         WarehouseShipmentLine.Modify();
//                     until WarehouseShipmentLine.Next() = 0;
//             until WarehouseShipmentHeader.Next() = 0;
//     end;
// }
