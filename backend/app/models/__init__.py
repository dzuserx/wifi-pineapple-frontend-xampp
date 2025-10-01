from sqlalchemy import Table, Column, Integer, String, Boolean, DateTime, ForeignKey, Text, Enum, MetaData
from sqlalchemy.dialects.mysql import TINYINT
from sqlalchemy.orm import registry

mapper_registry = registry()
metadata = mapper_registry.metadata

networks = Table(
    "networks",
    metadata,
    Column("ssid", String(255), primary_key=True),
    Column("bssid", String(17), unique=True),
    Column("channel", Integer),
    Column("signal", Integer),
    Column("encryption", String(50)),
    Column("client_count", Integer),
)

clients = Table(
    "clients",
    metadata,
    Column("mac", String(17), primary_key=True),
    Column("vendor", String(255)),
    Column("packets", Integer),
    Column("signal", Integer),
    Column("connected_ssid", String(255), ForeignKey("networks.ssid")),
)

interfaces = Table(
    "interfaces",
    metadata,
    Column("name", String(50), primary_key=True),
    Column("status", String(10)),
    Column("ip", String(15)),
    Column("mac", String(17)),
    Column("mode", String(20)),
)

dhcp_leases = Table(
    "dhcp_leases",
    metadata,
    Column("id", Integer, primary_key=True, autoincrement=True),
    Column("ip", String(15)),
    Column("mac", String(17)),
    Column("lease_start", DateTime),
    Column("lease_end", DateTime),
)

routing = Table(
    "routing",
    metadata,
    Column("id", Integer, primary_key=True, autoincrement=True),
    Column("destination", String(50)),
    Column("gateway", String(15)),
    Column("interface_name", String(50), ForeignKey("interfaces.name")),
    Column("metric", Integer),
)

ssid_pool = Table(
    "ssid_pool",
    metadata,
    Column("id", Integer, primary_key=True, autoincrement=True),
    Column("name", String(255)),
    Column("count", Integer),
    Column("added", DateTime),
)

pineapple_settings = Table(
    "pineapple_settings",
    metadata,
    Column("id", Integer, primary_key=True, default=1),
    Column("enabled", TINYINT(1)),
    Column("pool_size", Integer),
    Column("beacon_interval", Integer),
    Column("response_interval", Integer),
    Column("broadcast_ssid", TINYINT(1)),
    Column("log_associations", TINYINT(1)),
    Column("karma_mode", String(50)),
)

modules = Table(
    "modules",
    metadata,
    Column("id", Integer, primary_key=True, autoincrement=True),
    Column("name", String(255)),
    Column("version", String(20)),
    Column("description", Text),
    Column("enabled", TINYINT(1)),
    Column("author", String(255)),
    Column("size", Integer),
    Column("type", Enum("installed", "available")),
)

campaign_modes = Table(
    "campaign_modes",
    metadata,
    Column("id", String(50), primary_key=True),
    Column("name", String(255)),
    Column("description", Text),
)

campaigns = Table(
    "campaigns",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("name", String(255)),
    Column("status", String(50)),
    Column("mode", String(50)),
    Column("results", Integer),
    Column("description", Text),
    Column("created", DateTime),
    Column("last_run", DateTime),
)

reports = Table(
    "reports",
    metadata,
    Column("id", Integer, primary_key=True),
    Column("name", String(255)),
    Column("type", String(50)),
    Column("generated", DateTime),
    Column("size", String(20)),
)

activity_logs = Table(
    "activity_logs",
    metadata,
    Column("id", Integer, primary_key=True, autoincrement=True),
    Column("type", String(50)),
    Column("message", Text),
    Column("timestamp", DateTime),
    Column("client_mac", String(17), ForeignKey("clients.mac")),
)
