{-# LANGUAGE OverloadedStrings #-}
module Snap.Snaplet.Postgresql where

import           Control.Monad.IO.Class
import           Control.Monad.Logger
import           Control.Monad.State.Class
import           Data.ByteString
import           Database.Esqueleto          hiding (get)
import           Database.Persist            ()
import           Database.Persist.Postgresql (createPostgresqlPool)
import           Snap

initDb :: ByteString -> Int -> SnapletInit a ConnectionPool
initDb dbConnectString poolSize =
  makeSnaplet "connection-pool" "A simple Postgresql connection pool" Nothing .
  liftIO . runNoLoggingT $
  createPostgresqlPool dbConnectString poolSize

queryHandler :: SqlPersistM b -> Handler a ConnectionPool b
queryHandler query =
  do conn <- get
     liftIO $
       runSqlPersistMPool query conn
