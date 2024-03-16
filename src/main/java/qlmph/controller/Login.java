package qlmph.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import qlmph.DBUtil.DBUtil;
import qlmph.model.Account;

public class Login {
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginForm(Model model) {
        model.addAttribute("user", new Account());
        return "login/login";
    }
    
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String showRegisterForm(Model model) {
        model.addAttribute("user", new Account());
        return "login/register";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String processLogin(@ModelAttribute("user") Account user, RedirectAttributes redirectAttributes, HttpServletResponse response) {
        if (isValidUser(user.getUsername(), user.getPassword())) {
            Cookie cookie = new Cookie("username", user.getUsername());
            response.addCookie(cookie);
            return "redirect:/home.htm";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid username or password");
            return "redirect:/login.htm";
        }
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String registerUser(@ModelAttribute("user") Account user, RedirectAttributes redirectAttributes) {
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        if (createUser(user.getUsername(), hashedPassword)) {
            return "redirect:/login.htm";
        } else {
            redirectAttributes.addFlashAttribute("error", "Error creating user");
            return "redirect:/register.htm";
        }
    }

    private boolean isValidUser(String username, String password) {
        try {
            Connection connection = DBUtil.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT password FROM Account WHERE username = ?");
            preparedStatement.setString(1, username);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String hashedPassword = resultSet.getString("password");
                return BCrypt.checkpw(password, hashedPassword);
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean createUser(String username, String password) {
        try {
            Connection connection = DBUtil.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement("INSERT INTO Account (idAccount, idRole, username, password) VALUES (?, ?, ?, ?)");
            preparedStatement.setString(1, generateRandomId(connection));
            preparedStatement.setString(2, generateRandomId(connection));
            preparedStatement.setString(3, username);
            preparedStatement.setString(4, password);
            int rowsInserted = preparedStatement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Phương thức này sẽ tạo một GUID mới và kiểm tra xem nó đã tồn tại trong cơ sở dữ liệu hay chưa
    private String generateRandomId(Connection connection) throws SQLException {
        String randomId;
        do {
            randomId = UUID.randomUUID().toString();
        } while (checkIdExist(connection, randomId));
        return randomId;
    }

    // Phương thức này sẽ kiểm tra xem một giá trị đã tồn tại trong cơ sở dữ liệu hay chưa
    private boolean checkIdExist(Connection connection, String id) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement("SELECT COUNT(*) FROM Account WHERE idAccount = ? OR idRole = ?");
        preparedStatement.setString(1, id);
        preparedStatement.setString(2, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        int count = resultSet.getInt(1);
        return count > 0;
    }
}