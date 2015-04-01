{-# LANGUAGE OverloadedStrings #-}
module Snap.Snaplet.Postgresql where

import           Control.Monad.Logger
import           Data.ByteString
import           Data.Maybe
import           Database.Esqueleto
import           Database.Persist            ()
import           Database.Persist.Postgresql (createPostgresqlPool)
import           Snap

initDb :: ByteString -> Int -> SnapletInit a ConnectionPool
initDb dbConnectString poolSize =
  makeSnaplet "connection-pool" "A simple connection pool" Nothing .
  liftIO . runNoLoggingT $
  createPostgresqlPool dbConnectString poolSize

queryHandler :: SqlPersistM b -> Handler a ConnectionPool b
queryHandler query =
  do conn <- Snap.get
     liftIO (runSqlPersistMPool query conn)
