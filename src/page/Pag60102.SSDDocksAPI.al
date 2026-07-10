// page 60102 "SSD Docks API"
// {
//     APIGroup = 'plantautomation';
//     APIPublisher = 'ssd';
//     APIVersion = 'v2.0';
//     ApplicationArea = All;
//     Caption = 'Docks';
//     DelayedInsert = true;
//     EntityName = 'dock';
//     EntitySetName = 'docks';
//     PageType = API;
//     SourceTable = "SSD Dock";
//     Editable = false;
//     DataAccessIntent = ReadOnly;
//     Extensible = false;

//     layout
//     {
//         area(Content)
//         {
//             repeater(General)
//             {
//                 field("code"; Rec."Code")
//                 {
//                     Caption = 'Code';
//                 }
//                 field(description; Rec.Description)
//                 {
//                     Caption = 'Description';
//                 }
//                 field(locationCode; Rec."Location Code")
//                 {
//                     Caption = 'Location Code';
//                 }
//                 field(systemId; Rec.SystemId)
//                 {
//                     Caption = 'SystemId';
//                 }
//             }
//         }
//     }
// }
