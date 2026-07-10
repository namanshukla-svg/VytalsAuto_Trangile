// table 60007 "SSD Dock Lines"
// {
//     Caption = 'Dock Lines';
//     DataClassification = CustomerContent;
//     DrillDownPageId = "SSD Dock Lines";
//     LookupPageId = "SSD Dock Lines";

//     fields
//     {
//         field(1; "Entry No."; Integer)
//         {
//             Caption = 'Entry No.';
//         }
//         field(10; "Location Code"; Code[20])
//         {
//             Caption = 'Location Code';
//             TableRelation = Location;
//         }
//         field(15; "Dock No."; Code[20])
//         {
//             Caption = 'Dock No.';
//             TableRelation = "SSD Dock".Code where("Location Code"=field("Location Code"));
//         }
//         field(20; "Entry Type";Enum "SSD Whse. Transaction Type")
//         {
//             Caption = 'Entry Type';
//         }
//         field(25; "Planning Date"; Date)
//         {
//             Caption = 'Planning Date';
//         }
//         field(30; "Time Slot No."; Code[20])
//         {
//             Caption = 'Time Slot No.';
//             TableRelation = "SSD Dock Time Slots"."Slot No." where("Location Code"=field("Location Code"), "Dock No."=field("Dock No."));
//         }
//         field(35; "Time Slot Starting Time"; Time)
//         {
//             Caption = 'Slot Starting Time';
//         }
//         field(36; "Time Slot Ending Time"; Time)
//         {
//             Caption = 'Slot Ending Time';
//         }
//         field(50; Status;enum "SSD Dock Line Status")
//         {
//             Caption = 'Status';
//         }
//         field(100; "Gate Entry No."; Code[20])
//         {
//             Caption = 'Gate Entry No.';
//         }
//         field(110; "Gate Entry Date"; Date)
//         {
//             Caption = 'Gate Entry Date';
//         }
//         field(120; "Planning No."; Code[20])
//         {
//             Caption = 'Planning No.';
//         }
//         field(130; "Driver Code"; Code[10])
//         {
//             Caption = 'Driver Code';
//             DataClassification = CustomerContent;
//             TableRelation = "SSD Driver";
//             Editable = false;
//         }
//         field(140; "Driver Name"; Text[100])
//         {
//             Caption = 'Driver Name';
//             DataClassification = CustomerContent;
//             Editable = false;
//         }
//         field(150; "Vehicle No."; Code[20])
//         {
//             Caption = 'Vehicle No.';
//             DataClassification = CustomerContent;
//             TableRelation = "SSD Vehicle";
//             Editable = false;
//         }
//     }
//     keys
//     {
//         key(PK; "Entry No.")
//         {
//             Clustered = true;
//         }
//         key(Key2; "Location Code", "Dock No.", "Entry Type", "Time Slot No.")
//         {
//         }
//         key(Key3; Status, "Entry Type")
//         {
//         }
//     }
//     procedure UpdateGateEntry(PlanningNo: Code[20])
//     var
//         PostedGateEntry: Record "Posted Gate Entry Header";
//         UserSetup: Record "User Setup";
//     begin
//         UserSetup.Get(UserId);
//         if not UserSetup."Sepecial Permission" then Error('You are not authorized to do this action.');
//         if not confirm('Do you want to cntinue?,', false)then exit;
//         PostedGateEntry.Reset();
//         PostedGateEntry.SetRange("SSD Planning No.", PlanningNo);
//         if PostedGateEntry.FindFirst()then begin
//             rec."Gate Entry No.":=PostedGateEntry."No.";
//             rec."Gate Entry Date":=PostedGateEntry."Posting Date";
//             rec."Driver Code":=PostedGateEntry."SSD Driver Code";
//             rec."Driver Name":=PostedGateEntry."SSD Driver Name";
//             rec."Vehicle No.":=PostedGateEntry."Vehicle No.";
//             rec.Status:=rec.Status::"In-Process";
//             rec.Modify();
//         end;
//     end;
//     procedure DeleteLine(EntryNo: Integer)
//     var
//         UserSetup: Record "User Setup";
//         DockLines: Record "SSD Dock Lines";
//     begin
//         UserSetup.Get(UserId);
//         if not UserSetup."Sepecial Permission" then Error('You are not authorized to do this action.');
//         if not confirm('Do you want to continue?,', false)then exit;
//         DockLines.Reset();
//         DockLines.Get(EntryNo);
//         DockLines.Delete();
//         Message('Deleted');
//     end;
// }
