// page 60030 "SSD Dock Planning"
// {
//     ApplicationArea = All;
//     Caption = 'SSD Dock Planning';
//     PageType = List;
//     SourceTable = "SSD Dock Planning";
//     Editable = false;
//     InsertAllowed = false;
//     ModifyAllowed = false;
//     DeleteAllowed = false;
//     UsageCategory = None;

//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {
//                 field("Location Code"; Rec."Location Code")
//                 {
//                     ToolTip = 'Specifies the value of the Location Code field.', Comment = '%';
//                 }
//                 field("Dock No."; Rec."Dock No.")
//                 {
//                     ToolTip = 'Specifies the value of the Dock No. field.', Comment = '%';
//                 }
//                 field("Time Slot No."; Rec."Time Slot No.")
//                 {
//                     ToolTip = 'Specifies the value of the Time Slot No. field.', Comment = '%';
//                 }
//                 field("Planning Date"; Rec."Planning Date")
//                 {
//                     ToolTip = 'Specifies the value of the Planning Date field.', Comment = '%';
//                 }
//                 field("Item No."; Rec."Item No.")
//                 {
//                     ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
//                 }
//                 field("Item Description"; Rec."Item Description")
//                 {
//                     ToolTip = 'Specifies the value of the Item Description field.', Comment = '%';
//                 }
//                 field(Quantity; Rec.Quantity)
//                 {
//                     ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
//                 }
//                 field("Pallet Count"; Rec."Pallet Count")
//                 {
//                     ToolTip = 'Specifies the value of the Pallet Count field.', Comment = '%';
//                 }
//             }
//         }
//     }
//     actions
//     {
//         area(Processing)
//         {
//             group(Plan)
//             {
//                 action(CalculatePlan)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Calculate Plan';
//                     Image = Calculate;
//                     ToolTip = 'Executes the Calculate Plan action.';

//                     trigger OnAction()
//                     var
//                         SSDDockManagement: Codeunit "SSD Dock Management";
//                     begin
//                         SSDDockManagement.CalculateDockPlan();
//                     end;
//                 }
//             }
//         }
//         area(Promoted)
//         {
//             actionref(CalculatePlan_Promoted; CalculatePlan)
//             {
//             }
//         }
//     }
// }
