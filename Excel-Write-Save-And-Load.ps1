# Please enter path of Excel compatible file.
$ExcelPath = 'C:\file.xlsx'

# Initiate File Open
$excel = New-Object -ComObject Excel.Application
$excel.Visible = $true
$workbook = $excel.Workbooks.Open($ExcelPath)

# Set Values
$a1 = "Cell A1"
$b1 = "Cell B1"
$a2 = "Apple"
$b2 = "Pie"

# Write to Cells A1 and B1
$workbook.ActiveSheet.Cells.Item(1,1) = $a1
$workbook.ActiveSheet.Cells.Item(1,2) = $b1

# Write to Cells A2 and B2
$workbook.ActiveSheet.Cells.Item(2,1) = $a2
$workbook.ActiveSheet.Cells.Item(2,2) = $b2

# Save File
$workbook.Save()

# Grab Cell Data
$value1 = $workbook.ActiveSheet.Cells.Item(2,1).text
$value2 = $workbook.ActiveSheet.Cells.Item(2,2).text

# Exit Excel
$workbook.Close($true)
$excel.Quit()

# Print Cell Data
write-host $value1
write-host $value2

pause
