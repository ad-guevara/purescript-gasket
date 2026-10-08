module Gasket.Sheets.Domain where

import Prelude

newtype SpreadsheetId = SpreadsheetId String
derive newtype instance eqSpreadsheetId :: Eq SpreadsheetId

data SheetReference 
  = SheetByName String 
  | ActiveSheet
derive instance eqSheetReference :: Eq SheetReference

newtype A1Notation = A1Notation String
derive newtype instance eqA1Notation :: Eq A1Notation

newtype AbsoluteRange = AbsoluteRange 
  { targetSheet :: SheetReference
  , localRange  :: A1Notation 
  }
derive instance eqAbsoluteRange :: Eq AbsoluteRange

newtype CellValue = CellValue String
derive newtype instance eqCellValue :: Eq CellValue

type CellMatrix = Array (Array CellValue)

type ActiveContext = 
  { spreadsheetId :: SpreadsheetId
  , currentSheet  :: SheetReference 
  }

