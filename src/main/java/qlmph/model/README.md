  1. Sử dụng @Entity cho class Object liên kết tới bảng
  2. Sử dụng @Id cho biến liên kết với khóa chính của bảng
  3. Sử dụng @OneToOne hoặc @ManyToOne và @JoinColumn(name = "name_columnRef", referencedColumnName = "name_column") cho Object để liên kết với bảng được khóa ngoại của bảng này tham chiếu
  4. Sử dụng @OneToOne(mappedBy = "nameVal") hoặc @OneToMany(mappedBy = "nameVal") cho Object để liên kết Object được khóa ngoại của bảng khác tham chiếu
  5. Sử dụng @ManyToMany và @JoinTable(name = "name_Object", joinColumns = @JoinColumn(name = "name_columnRef"), inverseJoinColumns = @JoinColumn(name = "name_column") để liên kết Object thông qua bảng trung gian
# Lưu ý:
  1. Măc định @OneToMany và ManyToMany là  fetch=LAZY