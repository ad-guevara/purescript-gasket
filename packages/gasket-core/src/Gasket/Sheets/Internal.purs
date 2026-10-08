module Gasket.Sheets.Internal where

import Prelude
import Type.Proxy (Proxy(..))
import Type.Row (type (+))
import Run (Run, lift)
import Run.Reader (Reader, askAt, localAt, runReaderAt)
import Gasket.Sheets.Domain (SpreadsheetId, SheetReference, A1Notation, AbsoluteRange(..), CellMatrix, ActiveContext)

type SHEET_CTX = Proxy "sheetCtx"
_sheetCtx = Proxy :: Proxy "sheetCtx"

type SHEET_OP = Proxy "sheetOp"
_sheetOp = Proxy :: Proxy "sheetOp"

data SheetF a
  = ReadRange SpreadsheetId AbsoluteRange (CellMatrix -> a)
  | WriteRange SpreadsheetId AbsoluteRange CellMatrix a

derive instance functorSheetF :: Functor SheetF

type SHEET r = 
  ( sheetOp  :: SheetF
  , sheetCtx :: Reader ActiveContext 
  | r 
  )

readRange :: forall r. A1Notation -> Run (SHEET + r) CellMatrix
readRange notation = do
  ctx <- askAt _sheetCtx
  let absoluteRange = AbsoluteRange { targetSheet: ctx.currentSheet, localRange: notation }
  lift _sheetOp (ReadRange ctx.spreadsheetId absoluteRange identity)

writeRange :: forall r. A1Notation -> CellMatrix -> Run (SHEET + r) Unit
writeRange notation matrix = do
  ctx <- askAt _sheetCtx
  let absoluteRange = AbsoluteRange { targetSheet: ctx.currentSheet, localRange: notation }
  lift _sheetOp (WriteRange ctx.spreadsheetId absoluteRange matrix unit)

withActiveSheet :: forall r a. SheetReference -> Run (SHEET + r) a -> Run (SHEET + r) a
withActiveSheet sheet = localAt _sheetCtx _ { currentSheet = sheet }

runSheets :: forall r a. ActiveContext -> Run (SHEET + r) a -> Run (sheetOp :: SheetF | r) a
runSheets = runReaderAt _sheetCtx
