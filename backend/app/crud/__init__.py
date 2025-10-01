from sqlalchemy import select, insert, update, delete
from backend.app.models import clients, activity_logs
from backend.app.config import database

# Clients CRUD
async def get_client(mac: str):
    query = select(clients).where(clients.c.mac == mac)
    return await database.fetch_one(query)

async def get_clients():
    query = select(clients)
    return await database.fetch_all(query)

async def create_client(client_data):
    query = insert(clients).values(**client_data)
    return await database.execute(query)

async def update_client(mac: str, client_data):
    query = update(clients).where(clients.c.mac == mac).values(**client_data)
    return await database.execute(query)

async def delete_client(mac: str):
    query = delete(clients).where(clients.c.mac == mac)
    return await database.execute(query)

# Activity Logs CRUD
async def get_activity_logs():
    query = select(activity_logs)
    return await database.fetch_all(query)

async def create_activity_log(log_data):
    query = insert(activity_logs).values(**log_data)
    return await database.execute(query)
