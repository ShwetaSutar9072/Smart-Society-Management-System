package com.mycompany.smartsocietymca;

/**
 * The four subscription services. They used to be four copies of the same JSP pages;
 * now one page is driven by this table. Database tables are unchanged.
 */
public final class Catalog {

    public static final class Svc {
        public final int type;
        public final String name;          // value stored in addservices.service / otherservices.servicename
        public final String table;         // subscription table
        public final String nameCol;       // resident-name column (subscription uses name, the others rnm)
        public final String idCol;         // primary key column (the first table uses payid, the others payno)
        public final String title;
        public final String image;
        public final String[] features;

        Svc(int type, String name, String table, String title, String image, String... features) {
            this.type = type; this.name = name; this.table = table;
            this.idCol = "subscription".equals(table) ? "payid" : "payno";
            this.nameCol = "subscription".equals(table) ? "name" : "rnm";
            this.title = title; this.image = image; this.features = features;
        }
    }

    public static final Svc[] SERVICES = {
        new Svc(1, "Smart Security", "subscription", "Smart Security", "smartsecurity1.jpg",
                "Intrusion Alarm Solution", "Fire Alarm Solution", "Guard Monitoring and Assistance",
                "Emergency Response", "Central Monitoring Services", "Peripheral Security Solution"),
        new Svc(2, "Smart Core Cleaning Services", "subscription2", "Smart Core Cleaning Services", "cleaning1.jpg",
                "Residential Cleaning", "Commercial Cleaning", "Specialized Cleaning"),
        new Svc(3, "Smart Plumbing and Water services", "subscription3", "Smart Plumbing and Water Services", "water1.jpg",
                "Core Smart Services", "Water Quality Management"),
        new Svc(4, "Smart Core Electrical Services", "subscription4", "Smart Electrical Services", "electricity1.jpg",
                "Smart Lighting System", "Smart Switches and Outlets", "Smart Usage Monitoring"),
    };

    public static final String[] EVENTS = {
        "Birthday/Anniversary", "Festival Party", "Naming Ceremony", "Conference", "Others"
    };

    public static final String[] MONTHS = {
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    };

    private Catalog() { }

    /** Returns the service for type 1-4, or null. */
    public static Svc service(int type) {
        return (type >= 1 && type <= SERVICES.length) ? SERVICES[type - 1] : null;
    }
}
