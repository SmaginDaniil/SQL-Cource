-- Таблица пользователей
CREATE TABLE Users (
    Email TEXT PRIMARY KEY,
    FullName TEXT NOT NULL,
    PasswordHash TEXT NOT NULL,
    PhoneNumber TEXT,
    RegistrationDate TEXT NOT NULL -- Храним как ISO строку (например, '2024-06-14')
);

-- Таблица брендов
CREATE TABLE Brands (
    BrandName TEXT PRIMARY KEY,
    Country TEXT
);

-- Таблица категорий товаров
CREATE TABLE Categories (
    CategoryName TEXT PRIMARY KEY,
    Description TEXT
);

-- Таблица товаров
CREATE TABLE Products (
    ProductSKU TEXT PRIMARY KEY,
    ProductName TEXT NOT NULL,
    Description TEXT,
    Price REAL NOT NULL,
    CategoryName TEXT,
    BrandName TEXT,
    FOREIGN KEY (CategoryName) REFERENCES Categories(CategoryName),
    FOREIGN KEY (BrandName) REFERENCES Brands(BrandName)
);

-- Таблица складской доступности
CREATE TABLE Availability (
    ProductSKU TEXT,
    WarehouseLocation TEXT,
    InStock INTEGER CHECK (InStock >= 0),
    PRIMARY KEY (ProductSKU, WarehouseLocation),
    FOREIGN KEY (ProductSKU) REFERENCES Products(ProductSKU)
);

-- Таблица заказов
CREATE TABLE Orders (
    OrderID TEXT PRIMARY KEY,
    Email TEXT,
    OrderDate TEXT NOT NULL,
    Status TEXT NOT NULL,
    ShippingAddress TEXT,
    PaymentMethod TEXT,
    FOREIGN KEY (Email) REFERENCES Users(Email)
);

-- Таблица позиций в заказе
CREATE TABLE Order_Items (
    OrderID TEXT,
    ProductSKU TEXT,
    Quantity INTEGER CHECK (Quantity > 0),
    Price REAL NOT NULL,
    PRIMARY KEY (OrderID, ProductSKU),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductSKU) REFERENCES Products(ProductSKU)
);

-- Таблица отзывов
CREATE TABLE Reviews (
    Email TEXT,
    ProductSKU TEXT,
    Rating INTEGER CHECK (Rating BETWEEN 1 AND 5),
    ReviewText TEXT,
    ReviewDate TEXT NOT NULL,
    PRIMARY KEY (Email, ProductSKU),
    FOREIGN KEY (Email) REFERENCES Users(Email),
    FOREIGN KEY (ProductSKU) REFERENCES Products(ProductSKU)
);
