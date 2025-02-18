-- Enable Foreign Key enforcement in SQLite
PRAGMA foreign_keys = ON;


-- INVESTMENTS
CREATE TABLE IF NOT EXISTS investments (
    investment_id            INTEGER PRIMARY KEY AUTOINCREMENT,
    name                     TEXT    NOT NULL,
    investment_code          TEXT,
    investment_currency      TEXT,
    investment_market        TEXT,
    created_at               TEXT DEFAULT (datetime('now'))
);

-- CATEGORY_ALLOCATIONS
CREATE TABLE IF NOT EXISTS category_allocations (
    category_allocation_id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name                 TEXT    NOT NULL,
    created_at           TEXT    DEFAULT (datetime('now'))
);

-- CATEGORY_ALLOCATION_METHODS
CREATE TABLE IF NOT EXISTS category_allocation_methods (
    category_allocation_method_id    INTEGER PRIMARY KEY AUTOINCREMENT,
    category_allocation_id           INTEGER,
    category_allocation_weight       REAL,
    created_at                       TEXT    DEFAULT (datetime('now'))
    FOREIGN KEY (category_allocation_id)  REFERENCES category_allocations(category_allocation_id),
);

-- INVESTMENT_ALLOCATIONS
CREATE TABLE IF NOT EXISTS investment_allocations (
    investment_allocation_id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name                              TEXT    NOT NULL,
    created_at                        TEXT    DEFAULT (datetime('now'))
);

-- 2) INVESTMENT_ALLOCATION_METHODS
CREATE TABLE IF NOT EXISTS investment_allocation_methods (
    investment_allocation_method_id     INTEGER PRIMARY KEY AUTOINCREMENT,
    investment_method_id                INTEGER,
    investment_id                     INTEGER,
    allocation                        FLOAT,
    created_at    TEXT    DEFAULT (datetime('now')),
    FOREIGN KEY (investment_allocation_id)  REFERENCES investment_allocations(investment_allocation_id),
    FOREIGN KEY (investment_id)REFERENCES investments(investment_id)
);

-- PORTFOLIO_MODELS
CREATE TABLE IF NOT EXISTS portfolio_models (
    portfolio_model_id                 INTEGER PRIMARY KEY AUTOINCREMENT,
    portfolio_name                     TEXT,
    portfolio_type                     TEXT,
    category_allocation_method_id      INTEGER,  
    allocation_weight                  FLOAT,
    created_at                         TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (category_allocation_method_id) REFERENCES category_allocation_methods(category_allocation_method_id)
);

-- COMPLIANCE_TEMPLATE
CREATE TABLE IF NOT EXISTS compliance_template (
    compliance_template_id             INTEGER PRIMARY KEY AUTOINCREMENT,
    portfolio_model_id                 INTEGER,
    category_id                        INTEGER,
    category_allocation_method_id      INTEGER,
    category_allocation_min            INTEGER,
    category_allocation_max            INTEGER,
    created_at                         TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (category_method_id)  REFERENCES category_allocation_methods(category_method_id),
    FOREIGN KEY (category_id)REFERENCES categories(category_id)
    FOREIGN KEY (portfolio_model_id)REFERENCES portfolio_models(portfolio_model_id)
);

-- PORTFOLIO_COMPLIANCE_LINK
CREATE TABLE IF NOT EXISTS portfolio_compliance_link (
    link_id                     INTEGER PRIMARY KEY AUTOINCREMENT,
    portfolio_model_id          INTEGER NOT NULL,
    compliance_template_id      INTEGER NOT NULL,
    created_at                   TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (portfolio_model_id) REFERENCES portfolio_models(portfolio_model_id),
    FOREIGN KEY (compliance_template_id)  REFERENCES compliance_template(compliance_template_id)
);

-- PLATFORMS
CREATE TABLE IF NOT EXISTS platforms (
    platform_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    platform_name TEXT    NOT NULL,
    created_at    TEXT DEFAULT (datetime('now'))
);

-- INVESTMENTS
CREATE TABLE IF NOT EXISTS investments (
    investment_id   INTEGER PRIMARY KEY AUTOINCREMENT,
    name            TEXT    NOT NULL,
    symbol          TEXT,
    investment_type TEXT    NOT NULL,
    category_id     INTEGER,
    created_at      TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- 9) PLATFORM_INVESTMENTS
CREATE TABLE IF NOT EXISTS platform_investments (
    platform_investment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    platform_id            INTEGER NOT NULL,
    investment_id          INTEGER NOT NULL,
    created_at             TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (platform_id)   REFERENCES platforms(platform_id),
    FOREIGN KEY (investment_id) REFERENCES investments(investment_id)
);
