// page 60011 "SSD Receipt Dock In"
// {
//     ApplicationArea = All;
//     Caption = 'Receipt Dock In';
//     PageType = Card;
//     SourceTable = "SSD Dock";
//     UsageCategory = None;

//     layout
//     {
//         area(Content)
//         {
//             group(General)
//             {
//                 Caption = 'General';

//                 field(QRText; QRText)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Vehicle QR Code';
//                     ExtendedDatatype = Barcode;
//                     ToolTip = 'Specifies the value of the Vehicle QR value field.';

//                     trigger OnValidate()
//                     begin
//                         SSDDockManagement.ProcessReceiptDockIn(Rec, QRText);
//                         QRText:='';
//                     end;
//                 }
//             }
//         }
//     }
//     var SSDDockManagement: Codeunit "SSD Dock Management";
//     QRText: Text;
// }
