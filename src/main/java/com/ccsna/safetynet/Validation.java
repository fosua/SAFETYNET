package com.ccsna.safetynet;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;

public class Validation {

    /**
     *
     */
    private static final long serialVersionUID = 1L;
    public static final String ERROR = "Error";
    public static final String SUCCESS = "Success";
    /**
     * property holding the pattern value
     *
     */
    private static Map<String, String> $_patterns = new HashMap<String, String>(0);

    /**
     *
     */
    public Validation() {
    }

    public static enum Actions {
        CREATE,
        UPDATE,
        DELETE,
        RETRIEVE,
        CHANGESTATUS,
        LOGIN
    }

    public static enum Options {
        MEMBER,
        AGENCY,
        SERVICES,
        NEWS
    }

    public static enum InOut {
        LOGIN,
        LOGOUT
    }
     public static enum MemberActions {
        PERSONAL_INFO,
        RESET_PASSWORD,
    }
     
    public static enum AdminActions {
        AGENCY_PROFILE,
        MEMBER,
        OUR_SERVICES,
        CHANGE_PASSWORD
    }

    /**
     * Checks that a string contains something other than whitespace Returns
     * true if string contains something other than whitespace
     *
     * @return boolean true or false
     */
    public static boolean checkNotEmpty(String str) {
        if (null == str) {
            return false;
        }
        return str.matches("[^\\s]+");
    }

    /**
     * Checks that a string contains only integer or letters Returns true if
     * string contains only integer or letters
     *
     * @param String str
     * @return boolean true or false
     */
    public static boolean checkAlphaNumeric(String str) {
        return str.matches("^[\\p{Ll}\\p{Lm}\\p{Lo}\\p{Lt}\\p{Lu}\\p{Nd}]+$");
    }

    /**
     * Returns true if field is left blank -OR- only whitespace characters are
     * present in it's value
     *
     * @param String str
     * @return boolean true or false
     */
    public static boolean checkBlank(String str) {
        return str.matches("[^\\s]");
    }

    /**
     * Date validation, determines if the string passed is a valid date. It
     * helps validating date-related user input data
     *
     * @param String dateString
     * @param List<String> format. The possible formats to pass to the function
     * are : dmy 05-12-2011 or 05-12-11 separators can be a space, period, dash,
     * forward slash mdy 12-05-2011 or 12-05-11 separators can be a space,
     * period, dash, forward slash ymd 2011-12-05 or 11-12-05 separators can be
     * a space, period, dash, forward slash dMy 05 December 2011 or 05 Dec 2011
     * Mdy December 05, 2011 or Dec 05, 2011 comma is optional My December 2011
     * or Dec 2011 my 12/2011 separators can be a space, period, dash, forward
     * slash
     * @param String regex. This argument is optional. If a custom regular
     * expression is used this is the only validation that will occur
     * @return boolean true when the string is a valid date or false when it is
     * not
     */
    public static boolean checkDate(String dateString, List<String> format, String regex) {
        // Variable holding a mapping between the format and the regular expression identifying the given format
        Map<String, String> map = new HashMap<String, String>(0);

        // check whether a custom regular expression is given
        if (regex != null && !regex.isEmpty()) {
            return dateString.matches(regex);
        }

        // case where there is no regular expression provided.
        if (format != null && !format.isEmpty()) {
            // Loop through the format list and generate the appropriate regular expression.
            Iterator<String> loop = format.iterator();
            while (loop.hasNext()) {
                String frmt = loop.next();
                if (frmt.equals("dmy")) {
                    map.put("dmy", "^(?:(?:31(\\/|-|\\.|\\x20)(?:0?[13578]|1[02]))\\1|(?:(?:29|30)(\\/|-|\\.|\\x20)(?:0?[1,3-9]|1[0-2])\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$|^(?:29(\\/|-|\\.|\\x20)0?2\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\\d|2[0-8])(\\/|-|\\.|\\x20)(?:(?:0?[1-9])|(?:1[0-2]))\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$");
                }
                if (frmt.equals("mdy")) {
                    map.put("mdy", "^(?:(?:(?:0?[13578]|1[02])(\\/|-|\\.|\\x20)31)\\1|(?:(?:0?[13-9]|1[0-2])(\\/|-|\\.|\\x20)(?:29|30)\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$|^(?:0?2(\\/|-|\\.|\\x20)29\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:(?:0?[1-9])|(?:1[0-2]))(\\/|-|\\.|\\x20)(?:0?[1-9]|1\\d|2[0-8])\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$");
                }
                if (frmt.equals("ymd")) {
                    map.put("ymd", "^(?:(?:(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\\/|-|\\.|\\x20)(?:0?2\\1(?:29)))|(?:(?:(?:1[6-9]|[2-9]\\d)?\\d{2})(\\/|-|\\.|\\x20)(?:(?:(?:0?[13578]|1[02])\\2(?:31))|(?:(?:0?[1,3-9]|1[0-2])\\2(29|30))|(?:(?:0?[1-9])|(?:1[0-2]))\\2(?:0?[1-9]|1\\d|2[0-8]))))$");
                }
                if (frmt.equals("dMy")) {
                    map.put("dMy", "^((31(?!\\ (Feb(ruary)?|Apr(il)?|June?|(Sep(?=\\b|t)t?|Nov)(ember)?)))|((30|29)(?!\\ Feb(ruary)?))|(29(?=\\ Feb(ruary)?\\ (((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))|(0?[1-9])|1\\d|2[0-8])\\ (Jan(uary)?|Feb(ruary)?|Ma(r(ch)?|y)|Apr(il)?|Ju((ly?)|(ne?))|Aug(ust)?|Oct(ober)?|(Sep(?=\\b|t)t?|Nov|Dec)(ember)?)\\ ((1[6-9]|[2-9]\\d)\\d{2})$");
                }
                if (frmt.equals("Mdy")) {
                    map.put("Mdy", "^(?:(((Jan(uary)?|Ma(r(ch)?|y)|Jul(y)?|Aug(ust)?|Oct(ober)?|Dec(ember)?)\\ 31)|((Jan(uary)?|Ma(r(ch)?|y)|Apr(il)?|Ju((ly?)|(ne?))|Aug(ust)?|Oct(ober)?|(Sep)(tember)?|(Nov|Dec)(ember)?)\\ (0?[1-9]|([12]\\d)|30))|(Feb(ruary)?\\ (0?[1-9]|1\\d|2[0-8]|(29(?=,?\\ ((1[6-9]|[2-9]\\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00)))))))\\,?\\ ((1[6-9]|[2-9]\\d)\\d{2}))$");
                }
                if (frmt.equals("My")) {
                    map.put("My", "^(Jan(uary)?|Feb(ruary)?|Ma(r(ch)?|y)|Apr(il)?|Ju((ly?)|(ne?))|Aug(ust)?|Oct(ober)?|(Sep(?=\\b|t)t?|Nov|Dec)(ember)?)[ /]((1[6-9]|[2-9]\\d)\\d{2})$");
                }
                if (frmt.equals("my")) {
                    map.put("my", "^(((0[123456789]|10|11|12)([- /\\.])(([1][9][0-9][0-9])|([2][0-9][0-9][0-9]))))$");
                }
            }

            // validate the dateString
            for (Map.Entry<String, String> patterns : map.entrySet()) {
                String rgx = patterns.getValue();
                if (dateString.matches(rgx)) {
                    return true;
                }
            }
        } else {
            if (dateString.matches("^(?:(?:(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00)))(\\/|-|\\.|\\x20)(?:0?2\\1(?:29)))|(?:(?:(?:1[6-9]|[2-9]\\d)?\\d{2})(\\/|-|\\.|\\x20)(?:(?:(?:0?[13578]|1[02])\\2(?:31))|(?:(?:0?[1,3-9]|1[0-2])\\2(29|30))|(?:(?:0?[1-9])|(?:1[0-2]))\\2(?:0?[1-9]|1\\d|2[0-8]))))$")) {
                return true;
            }
        }
        return false;
    }

    /**
     * Validates a datetime value. All values matching the "date" core
     * validation rule, and the "time" one will be valid
     *
     * @param String dateTimeString
     * @param List<String> format. The possible formats to pass to the function
     * are : dmy 05-12-2011 or 05-12-11 separators can be a space, period, dash,
     * forward slash mdy 12-05-2011 or 12-05-11 separators can be a space,
     * period, dash, forward slash ymd 2011-12-05 or 11-12-05 separators can be
     * a space, period, dash, forward slash dMy 05 December 2011 or 05 Dec 2011
     * Mdy December 05, 2011 or Dec 05, 2011 comma is optional My December 2011
     * or Dec 2011 my 12/2011 separators can be a space, period, dash, forward
     * slash
     * @param String regex. This argument is optional. If a custom regular
     * expression is used this is the only validation that will occur
     * @return boolean true when the string is a valid datetime or false when it
     * is not
     */
    public static boolean checkDateTime(String dateString, List<String> format, String regex) {
        // variable holding the end result
        boolean valid = false;
        // Get the various parts of the dateString.
        String[] parts = dateString.split(" ");
        if (parts != null && parts.length > 1) {
            // Get the time part
            String time = parts[parts.length - 1];
            // Reconstruct the date parts
            String date = parts[0];
            for (int i = 1; i < parts.length - 2; i++) {
                date += " " + parts[i];
            }
            // pass to the validation function
            valid = Validation.checkDate(date, format, regex) && Validation.checkTime(time);
        }
        return valid;
    }

    /**
     * Time validation, determines if the string passed is a valid time.
     * Validates time as 24hr (HH:MM) or am/pm ([H]H:MM[a|p]m) Does not
     * allow/validate seconds.
     *
     * @param String time a valid time string
     * @return boolean true when time is valid or false
     */
    public static boolean checkTimeAs24h(String time) {
        return time.matches("^((0?[1-9]|1[012])(:[0-5]\\d){0,2} ?([AP]M|[ap]m))$|^([01]\\d|2[0-3])(:[0-5]\\d){0,2}$");
    }

    /**
     * Time validation, determines if the string passed is a valid time.
     * Validates times as 12hr or 24hr (HH:MM) or am/pm ([H]H:MM[a|p]m) Matches
     * times separated by either : or . will match a 24 hour time, or a 12 hour
     * time with AM or PM specified. Allows 0-59 minutes, and 0-59 seconds.
     * Seconds are not required.
     *
     * @param String time a valid time string
     * @return boolean true when time is valid or false
     */
    public static boolean checkTime(String time) {
        return time.matches("^((([0]?[1-9]|1[0-2])(:|\\.)[0-5][0-9]((:|\\.)[0-5][0-9])?( )?(AM|am|aM|Am|PM|pm|pM|Pm))|(([0]?[0-9]|1[0-9]|2[0-3])(:|\\.)[0-5][0-9]((:|\\.)[0-5][0-9])?))$");
    }

    /**
     * Checks that a value is a valid decimal. If places is null, the check is
     * allowed to be a scientific float If no decimal point is found a false
     * will be returned. Both the sign and exponent are optional. It returns
     * true when it is successful or false when check is not a valid decimal
     * number
     *
     * @param String check The value the test for decimal
     * @param int places if set check value must have exactly places after the
     * decimal point. The default value is zero.
     * @param String regex. This argument is optional. If a custom regular
     * expression is used this is the only validation that will occur
     * @return boolean true or false
     */
    public static boolean checkDecimal(String check, int places, String regex) {
        // variable holding the pattern
        String pattern = "";
        // check whether a custom regular expression is given
        if (regex != null && !regex.isEmpty()) {
            return check.matches(regex);
        }

        // check whether the places is set or not
        if (places > 0) {
            pattern = "^[-+]?[0-9]*\\.{1}[0-9]{" + places + "}$";
        } else if (places == 0) {
            pattern = "^[-+]?[0-9]*\\.{1}[0-9]+(?:[eE][-+]?[0-9]+)?$";
        }

        return check.matches(pattern);
    }

    /**
     * Checks that a value is a valid phone number. The format used is either: -
     * ITU-T E.164 standard format which is for instance : +233247063817.
     * According to ITU-T E.164 phone number are not mor than 15 characters. or
     * : - EPP format which is : +CCC.NNNNNNNNNNxEEEE where C is the 1�3 digit
     * country code, N is up to 14 digits, and E is the (optional) extension.
     * for more information about phone number please read:
     * @link http://www.itu.int/rec/T-REC-E.123
     * @link http://tools.ietf.org/html/rfc4933
     * @link http://www.itu.int/ITU-T/inr/nnp
     * @link http://www.itu.int/rec/T-REC-E.164
     *
     * @param String phoneNumber
     * @param String standard .The possible values are ITU and EPP . The default
     * value is ITU
     * @return true when it is valid international phone number or false when it
     * is not.
     */
    public static boolean checkInternationalTelephoneNumber(String phoneNumber, String standard) {
        String regex = ""; // ITU-T E.164 standard
        if (phoneNumber.substring(0, 3).equalsIgnoreCase("234")) {
            regex = "^\\(?([0-9]{3})\\)?([1-9]){1}([0-9]{9})$"; // ITU-T E.164 standard  
        } else {
            regex = "^\\(?([0-9]{3})\\)?([1-9]){1}([0-9]{8})$";  // ITU-T E.164 standard
        }
        if (standard.equalsIgnoreCase("EPP")) {
            regex = "^\\[0-9]{1,3}\\.[0-9]{4,14}(?:x\\.+)?$"; // EPP standard
        }

        return phoneNumber.trim().matches(regex);
    }

    /**
     * Checks that a value is a valid mobile number
     *
     * @param String networkPrefix
     * @param String phoneNumber
     * @return true when it is a valid mobile number or false when it is not.
     */
    public static boolean checkCellPhoneNumber(String networkPrefix, String phoneNumber) {
        String regex = "^[0]?" + networkPrefix + "[0-9]{6,14}$";
        return phoneNumber.trim().matches(regex);
    }

    //<editor-fold defaultstate="collapsed" desc="comment">
    /**
     * Validates for an ecg meter number
     *
     * @param String meterNumber to validate
     * @return boolean true when the meterNumber is valid and false when it is
     * invalid.
     */
    public static boolean checkEcgMeterNumber(String meterNumber) {
        String regex = "^([0-9]{10})$";

        return meterNumber.trim().matches(regex);
    }
    //</editor-fold>

    /**
     * Function to validate url
     *
     * @param String url
     * @return boolean true when the url is valid and false when it is invalid.
     */
    public static boolean checkUrl(String url) {
        // regular expression
        String regex = "^(?:(?:(ht|f)tps?|file|news|gopher)://)?(([\\w!~*'()\\.&=+$%-]+: )?[\\w!~*'()\\.&=+$%-]+@)?(([0-9]{1,3}\\.){3}[0-9]{1,3}|([\\w!~*'()-]+\\.)*([\\w^-][\\w-]{0,61})?[\\w]\\.[a-z]{2,6})(:[0-9]{1,4})?((/*)|(/+[\\w!~*'()\\.;?:@&=+$,%#-]+)+/*)$";
        return url.matches(regex);
    }

    /**
     * Validates for an email address.
     *
     * @param String email to validate
     * @return boolean true when the email is valid and false when it is
     * invalid.
     */
    public static boolean checkEmail(String email) {
        String regex = "^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|asia|jobs|museum)$";
        return email.matches(regex);
    }

    /**
     * Checks IP v4 address
     *
     * @param String ipAddress
     * @param String regex
     * @return boolean true when it is valid IPv4 or false when it is not.
     */
    public static boolean checkIPv4(String ipAddress, String regex) {
        // check whether a custom regular expression is given
        if (regex != null && !regex.isEmpty()) {
            return ipAddress.matches(regex);
        }

        // Lazily load the address pattern and validate the ipAddress
        Validation.populateIp();
        return ipAddress.matches(Validation.$_patterns.get("IPv4"));
    }

    /**
     * Checks IP v6 address
     *
     * @param String ipAddress
     * @param String regex
     * @return boolean true when it is valid IPv6 or false when it is not
     */
    public static boolean checkIPv6(String ipAddress, String regex) {
        // check whether a custom regular expression is given
        if (regex != null && !regex.isEmpty()) {
            return ipAddress.matches(regex);
        }

        // Lazily load the address pattern and validate the ipAddress
        Validation.populateIp();
        return ipAddress.matches(Validation.$_patterns.get("IPv6"));
    }

    /**
     * Checks IP address
     *
     * @param String ipAddress
     * @param String regex
     * @return boolean true when it is valid address and false when it is not
     * valid
     */
    public static boolean checkIp(String ipAddress, String regex) {
        return Validation.checkIPv4(ipAddress, regex) || Validation.checkIPv6(ipAddress, regex);
    }

    /**
     * Checks whether the length of a string is greater or equal to a minimal
     * length.
     *
     * @param String check The string to test
     * @param int min The minimal string length
     * @return boolean true when the length of a string is greater or equal to a
     * minimal length and false when it is not.
     */
    public static boolean checkMinimumLength(String check, int min) {
        return check.length() >= min;
    }

    /**
     * Checks whether the length of a string is smaller or equal to a maximal
     * length.
     *
     * @param String check The string to test
     * @param int max The minimal string length
     * @return boolean true when the string length is smaller or equal to a
     * maximal length and false when it is not.
     */
    public static boolean checkMaximumLength(String check, int max) {
        return check.length() <= max;
    }

    /**
     * Checks that a value is a monetary amount.
     *
     * @param String check The string to test
     * @param String symbolPosition The place Where symbol is located
     * (left/right). When it is set to null the left value is the default.
     * @return boolean true when the value is a monetary value and false when it
     * is not.
     */
    public static boolean checkMoney(String check, String symbolPosition) {
        // variable holding the money pattern
        String money = "(?!0,?\\d)(?:\\d{1,3}(?:([,\\.])\\d{3})?(?:\\1\\d{3})*|(?:\\d+))((?!\\1)[,\\.]\\d{2})?";
        String regex = "";
        if (symbolPosition.equals("right")) {
            regex = "^" + money + "(?<!\\x{00a2})\\p{Sc}?$";
        }
        regex = "^(?!\\x{00a2})\\p{Sc}?" + money + "$";

        // perform the test
        return check.matches(regex);
    }

    /**
     * Checks that a string contains only alphabets Returns true when the string
     * contains only word and false on the contrary
     *
     * @param String str
     * @param String regx
     * @return boolean true or false
     */
    public static boolean checkWord(String str, String regx) {
        // check whether a custom regular expression is given
        if (regx != null && !regx.isEmpty()) {
            return str.matches(regx);
        }

        String regex = "^[a-zA-Z0-9-\\s+]*$";
        return str.trim().matches(regex);
    }

    /**
     * Checks that a string is a valid alias Returns true when it is a valid
     * alias or false on the contrary
     *
     * @param String str
     * @param String regex
     * @return boolean true or false
     */
    public static boolean checkAlias(String str, String regex) {
        // check whether a custom regular expression is given
        if (regex != null && !regex.isEmpty()) {
            return str.matches(regex);
        }

        return str.trim().matches("^[a-zA-Z0-9]{3,10}$");
    }

    /**
     * Checks if a value is numeric.
     *
     * @param String check The string to test
     * @return boolean true when the value is numeric and false when it is not.
     */
    public static boolean checkNumeric(String check) {
        if (check == null) {
            return false;
        }
        return check.matches("^[-+]?[0-9]+$");
    }

    /**
     * Checks if a value is null.
     *
     * @param String check The string to test
     * @return boolean true when it is null and false when it is not
     */
    public static boolean checkNullity(String check) {
        return (check == null || check.isEmpty());
    }

    /**
     * Lazily populate the IP address patterns used for validations
     *
     * @return void
     */
    protected static void populateIp() {
        // variable holding pattern
        String pattern = "";
        // check whether the $_patterns is set for IPv6 or not
        if (!Validation.$_patterns.containsKey("IPv6")) {
            pattern = "((([0-9A-Fa-f]{1,4}:){7}(([0-9A-Fa-f]{1,4})|:))|(([0-9A-Fa-f]{1,4}:){6}";
            pattern += "(:|((25[0-5]|2[0-4]\\d|[01]?\\d{1,2})(\\.(25[0-5]|2[0-4]\\d|[01]?\\d{1,2})){3})";
            pattern += "|(:[0-9A-Fa-f]{1,4})))|(([0-9A-Fa-f]{1,4}:){5}((:((25[0-5]|2[0-4]\\d|[01]?\\d{1,2})";
            pattern += "(\\.(25[0-5]|2[0-4]\\d|[01]?\\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:)";
            pattern += "{4}(:[0-9A-Fa-f]{1,4}){0,1}((:((25[0-5]|2[0-4]\\d|[01]?\\d{1,2})(\\.(25[0-5]|2[0-4]\\d|[01]?\\d{1,2}))";
            pattern += "{3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){3}(:[0-9A-Fa-f]{1,4}){0,2}";
            pattern += "((:((25[0-5]|2[0-4]\\d|[01]?\\d{1,2})(\\.(25[0-5]|2[0-4]\\d|[01]?\\d{1,2})){3})?)|";
            pattern += "((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:){2}(:[0-9A-Fa-f]{1,4}){0,3}";
            pattern += "((:((25[0-5]|2[0-4]\\d|[01]?\\d{1,2})(\\.(25[0-5]|2[0-4]\\d|[01]?\\d{1,2}))";
            pattern += "{3})?)|((:[0-9A-Fa-f]{1,4}){1,2})))|(([0-9A-Fa-f]{1,4}:)(:[0-9A-Fa-f]{1,4})";
            pattern += "{0,4}((:((25[0-5]|2[0-4]\\d|[01]?\\d{1,2})(\\.(25[0-5]|2[0-4]\\d|[01]?\\d{1,2})){3})?)";
            pattern += "|((:[0-9A-Fa-f]{1,4}){1,2})))|(:(:[0-9A-Fa-f]{1,4}){0,5}((:((25[0-5]|2[0-4]";
            pattern += "\\d|[01]?\\d{1,2})(\\.(25[0-5]|2[0-4]\\d|[01]?\\d{1,2})){3})?)|((:[0-9A-Fa-f]{1,4})";
            pattern += "{1,2})))|(((25[0-5]|2[0-4]\\d|[01]?\\d{1,2})(\\.(25[0-5]|2[0-4]\\d|[01]?\\d{1,2})){3})))(%.+)?";

            Validation.$_patterns.put("IPv6", pattern);
        }

        // check whether the $_patterns is set for IPv4 or not
        if (!Validation.$_patterns.containsKey("IPv4")) {
            pattern = "(?:(?:25[0-5]|2[0-4][0-9]|(?:(?:1[0-9])?|[1-9]?)[0-9])\\.){3}(?:25[0-5]|2[0-4][0-9]|(?:(?:1[0-9])?|[1-9]?)[0-9])";
            Validation.$_patterns.put("IPv4", pattern);
        }
    }

    /**
     *
     * @param date
     * @return boolean true when the date is valid and false when it is not
     */
    public static boolean checkDate(String date) {
        String expression = "^(18|19|20|21)\\d{2}[-]?(0[1-9]|[12][0-9]|3[01])[-]?[0-1][1-9]$";

        System.out.println("Valid Check : " + "1920-02-22".matches(expression));
        System.out.println("Valid Check : " + expression.matches("2002-12-11"));
        if (date.isEmpty() || date.equals("null")) {
            return false;
        }

        return date.matches(expression);
    }

    /**
     *
     * @param bool
     * @return true if the string is either 1 or 0 or false if otherwise
     */
    public static boolean checkNumericBoolean(String bool) {

        if (bool.isEmpty()) {
            return false;
        }
        if (bool.equalsIgnoreCase("1") || bool.endsWith("0")) {
            return true;
        }
        return false;
    }

    /**
     *
     * @param bool
     * @return true if the string is either true or false or false if otherwise
     */
    public static boolean checkBoolean(String bool) {

        if (bool.isEmpty()) {
            return false;
        }

        if (bool.equalsIgnoreCase("true") || bool.endsWith("false")) {
            return true;
        }
        return false;
    }

    public static void setAttributes(HttpServletRequest request, String objName, String msg) {
        removeAttributes(request, objName);
        request.getSession().setAttribute(objName, msg);
    }

    public static void removeAttributes(HttpServletRequest request, String objName) {
        if (request.getSession().getAttribute(objName) != null) {
            System.out.println("the object being removed is : " + objName);
            request.getSession().removeAttribute(objName);
        }
       
    }

}
