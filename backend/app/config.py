from databases import Database
from sqlalchemy import create_engine, MetaData

DATABASE_URL = "mysql+aiomysql://user:password@localhost/db_wifi_pineapple"

database = Database(DATABASE_URL)
engine = create_engine(DATABASE_URL)
metadata = MetaData()
